class ApiConstant {
  ApiConstant._(); // private constructor

  static const String serverUri = 'http://192.168.1.9:8080';

  static const String baseUrl = '$serverUri/api';

  static const connectionTimeoutDuration = Duration(seconds: 1000);
  static const recieveTimeoutDuration = Duration(seconds: 1000);

  static const String register = '$baseUrl/auth/register';
}
