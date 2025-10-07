class ApiConstant {
  ApiConstant._(); // private constructor

  static const String serverUri = 'http://10.0.2.2:8080';

  static const String baseUrl = '$serverUri/api/v1';

  static const connectionTimeoutDuration = Duration(seconds: 20);
  static const recieveTimeoutDuration = Duration(seconds: 20);

  static const String register = '$baseUrl/auth/register';
  static const String login = '$baseUrl/auth/login';
  static const String verify = '$baseUrl/auth/verify';
  static const String resendVerification = '$baseUrl/auth/verification/resend';
  static const String refreshToken = '$baseUrl/auth/token/refresh';
  static const String logout = '$baseUrl/auth/logout';
}
