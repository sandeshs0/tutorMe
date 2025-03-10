class ApiEndpoints {
  ApiEndpoints._();
  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://10.0.2.2:3000/";
  // To Run in USB Android Device:
  // static const String baseUrl = "http://192.168.18.29:3000/";

  // Routes for Auth
  static const String register = "auth/register";
  static const String login = "auth/login";
  static const String verifyEmail = "auth/verify-email";

  // Routes for Tutors
  static const String getAllTutors = "api/tutors";
  static const String getTutorProfile = "api/tutors/profile";

  // Routes for Student Profile Fetching
  static const String getStudentProfile = "api/student/profile";

  // Routes for Wallet
  static const String initiateTransaction = "api/transaction/initiate";
  static const String verifyTransaction = "api/transaction/verify";
  static const String getWalletBalance = "api/transaction/balance";
  static const String getTransactions = "api/transaction/history";

// Routes for Notification
  static const String fetchNotifications = "api/notifications";
  static const String readNotification = "api/notifications/mark-read";

  // Routes for Booking:
  static String createBooking = "api/bookings/request";
  static String getStudentBookings = "api/bookings/student";

  // Routes for Sessions
  static String getStudentSessions = "api/sessions/student";
}
