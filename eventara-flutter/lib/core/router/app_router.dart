import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/organizer_apply_page.dart';
import '../../features/customer/presentation/pages/home_page.dart';
import '../../features/customer/presentation/pages/event_detail_page.dart';
import '../../features/customer/presentation/pages/seat_map_page.dart';
import '../../features/customer/presentation/pages/payment_page.dart';
import '../../features/customer/presentation/pages/booking_confirmation_page.dart';
import '../../features/customer/presentation/pages/ticket_display_page.dart';
import '../../features/customer/presentation/pages/booking_history_page.dart';
import '../../features/customer/presentation/pages/profile_page.dart';
import '../../features/landing/landing_page.dart';
import 'app_routes.dart';

// ── Auth guard helpers ────────────────────────────────────────────────────────

/// Set to true during UI development to bypass auth checks.
/// Flip to false once login/JWT flow is wired up.
const bool _bypassGuard = true;

/// Reads the stored JWT role from SharedPreferences.
Future<String?> _readRole() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('user_role'); // stored as 'ROLE_CUSTOMER' etc.
}

/// Redirect callback used by every /customer/* route.
/// Returns null (allow) or a redirect path (deny).
Future<String?> _customerGuard(GoRouterState state) async {
  if (_bypassGuard) return null; // ← remove when auth is ready
  final role = await _readRole();
  if (role == null) return AppRoutes.login;
  if (role != 'ROLE_CUSTOMER') return AppRoutes.login;
  return null;
}

// ── Router provider ───────────────────────────────────────────────────────────

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    routes: [
      // ── Landing ─────────────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const LandingPage(),
      ),

      // ── Auth ─────────────────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: AppRoutes.organizerApply,
        builder: (context, state) => const OrganizerApplyPage(),
      ),

      // ── Customer shell ────────────────────────────────────────────────────────
      // All /customer/* routes live here. Each route redirects if not authorised.
      ShellRoute(
        builder: (context, state, child) => child,
        routes: [
          GoRoute(
            name: 'customerHome',
            path: AppRoutes.customerHome,
            redirect: (context, state) async => _customerGuard(state),
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            name: 'customerEventDetail',
            path: AppRoutes.customerEventDetail,
            redirect: (context, state) async => _customerGuard(state),
            builder: (context, state) {
              final id = state.pathParameters['id'] ?? '';
              return EventDetailPage(eventId: id);
            },
          ),
          GoRoute(
            name: 'customerSeatMap',
            path: AppRoutes.customerSeatMap,
            redirect: (context, state) async => _customerGuard(state),
            builder: (context, state) {
              final id = state.pathParameters['id'] ?? '';
              return SeatMapPage(eventId: id);
            },
          ),
          GoRoute(
            name: 'customerPayment',
            path: AppRoutes.customerPayment,
            redirect: (context, state) async => _customerGuard(state),
            builder: (context, state) {
              final id = state.pathParameters['id'] ?? '';
              return PaymentPage(eventId: id);
            },
          ),
          GoRoute(
            name: 'customerBookingConfirmation',
            path: AppRoutes.customerBookingConfirmation,
            redirect: (context, state) async => _customerGuard(state),
            builder: (context, state) {
              final id = state.pathParameters['id'] ?? '';
              return BookingConfirmationPage(
                bookingRef: id,
                eventName: state.uri.queryParameters['eventName'] ?? '',
                eventDate: state.uri.queryParameters['eventDate'] ?? '',
                venue: state.uri.queryParameters['venue'] ?? '',
                holderName: state.uri.queryParameters['holderName'] ?? '',
                seatsCount: state.uri.queryParameters['seatsCount'] ?? '1',
                totalPrice: state.uri.queryParameters['totalPrice'] ?? '0',
              );
            },
          ),
          GoRoute(
            name: 'customerMyTickets',
            path: AppRoutes.customerMyTickets,
            redirect: (context, state) async => _customerGuard(state),
            builder: (context, state) => const TicketDisplayPage(),
          ),
          GoRoute(
            name: 'customerBookingHistory',
            path: AppRoutes.customerBookingHistory,
            redirect: (context, state) async => _customerGuard(state),
            builder: (context, state) => const BookingHistoryPage(),
          ),
          GoRoute(
            name: 'customerProfile',
            path: AppRoutes.customerProfile,
            redirect: (context, state) async => _customerGuard(state),
            builder: (context, state) => const ProfilePage(),
          ),
        ],
      ),
    ],

    // Global error page
    errorBuilder: (context, state) => Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),
      body: Center(
        child: Text(
          'Page not found: ${state.uri}',
          style: const TextStyle(color: Colors.white70),
        ),
      ),
    ),
  );
});
