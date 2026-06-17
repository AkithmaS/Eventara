/// Centralized route path constants for the Eventara app.
class AppRoutes {
  AppRoutes._();

  // ── Auth ──────────────────────────────────────────────────────────────────
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const organizerApply = '/organizer-apply';

  // ── Customer ──────────────────────────────────────────────────────────────
  static const customerHome = '/customer/home';
  static const customerEventDetail = '/customer/event-detail/:id';
  static const customerSeatMap = '/customer/seat-map/:id';
  static const customerPayment = '/customer/payment/:id';
  static const customerBookingConfirmation = '/customer/booking-confirmation/:id';
  static const customerMyTickets = '/customer/my-tickets';
  static const customerBookingHistory = '/customer/booking-history';
  static const customerProfile = '/customer/profile';

  // ── Helpers to build parameterised paths ─────────────────────────────────
  static String eventDetail(String id) => '/customer/event-detail/$id';
  static String seatMap(String id) => '/customer/seat-map/$id';
  static String payment(String id) => '/customer/payment/$id';
  static String bookingConfirmation(String id) => '/customer/booking-confirmation/$id';
}
