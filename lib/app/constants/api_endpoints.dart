class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout= Duration(seconds:1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://10.0.2.2:3000/";

  // Routes for Auth
  static const String register="auth/register";
  static const String login="auth/login";
  static const String verifyEmail="auth/verify-email";

}