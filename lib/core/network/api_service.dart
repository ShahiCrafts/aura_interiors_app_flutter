import 'package:aura_interiors/app/constant/api/api_constant.dart';
import 'package:aura_interiors/app/service_locator/get_it.dart';
import 'package:aura_interiors/core/network/auth_interceptor.dart';
import 'package:aura_interiors/core/network/auth_service.dart';
import 'package:aura_interiors/core/network/dio_error_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  final Dio _dio;

  Dio get dio => _dio;

  ApiService(this._dio) {
    dio
      ..options.baseUrl = ApiConstant.baseUrl
      ..options.connectTimeout = ApiConstant.connectionTimeoutDuration
      ..options.receiveTimeout = ApiConstant.recieveTimeoutDuration
      ..options.headers = {'Accept': 'application/json'}
      ..interceptors.add(AuthInterceptor(authService: getIt<AuthService>()))
      ..interceptors.add(DioErrorInterceptor())
      ..interceptors.add(
        PrettyDioLogger(request: true, requestBody: true, requestHeader: true),
      );
  }
}
