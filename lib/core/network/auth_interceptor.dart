import 'package:aura_interiors/core/network/auth_service.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  final AuthService authService;

  AuthInterceptor({required this.authService});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await authService.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      await authService.signOut();
    }
  }
}
