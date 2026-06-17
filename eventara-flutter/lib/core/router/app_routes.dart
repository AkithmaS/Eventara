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

  // ── Organizer ─────────────────────────────────────────────────────────────
  static const organizerDashboard = '/organizer/dashboard';
  static const organizerMyEvents = '/organizer/my-events';
  static const organizerCreateEvent = '/organizer/create-event';
  static const organizerEditEvent = '/organizer/edit-event/:id';
  static const organizerEventSubmissions = '/organizer/event-submissions';
  static const organizerBookings = '/organizer/bookings';
  static const organizerQRScanner = '/organizer/qr-scanner';
  static const organizerSeatMapEditor = '/organizer/seat-map-editor/:id';
  static const organizerPricingSetup = '/organizer/pricing-setup/:id';
  static const organizerReports = '/organizer/reports';
  static const organizerProfile = '/organizer/profile';

  // ── Helpers to build parameterised paths ─────────────────────────────────
  static String buildCustomerEventDetail(String id) => '/customer/event-detail/$id';
  static String buildCustomerSeatMap(String id) => '/customer/seat-map/$id';
  static String buildCustomerPayment(String id) => '/customer/payment/$id';
  static String buildCustomerBookingConfirmation(String id) =>
      '/customer/booking-confirmation/$id';
  static String buildOrganizerEditEvent(String id) => '/organizer/edit-event/$id';
  static String buildOrganizerSeatMapEditor(String id) => '/organizer/seat-map-editor/$id';
  static String buildOrganizerPricingSetup(String id) => '/organizer/pricing-setup/$id';
}
