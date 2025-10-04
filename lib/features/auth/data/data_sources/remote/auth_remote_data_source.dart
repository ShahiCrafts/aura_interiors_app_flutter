import 'package:aura_interiors/app/constant/api/api_constant.dart';
import 'package:aura_interiors/core/network/api_service.dart';
import 'package:aura_interiors/features/auth/data/data_sources/auth_data_source.dart';
import 'package:aura_interiors/features/auth/data/dto/auth_request_dto.dart';
import 'package:aura_interiors/features/auth/data/dto/auth_response_dto.dart';
import 'package:aura_interiors/features/auth/data/dto/refresh_token_request_dto.dart';
import 'package:aura_interiors/features/auth/data/dto/resend_verification_request_dto.dart';
import 'package:aura_interiors/features/auth/data/dto/verify_request_dto.dart';
import 'package:aura_interiors/features/auth/domain/entities/token_entity.dart';
import 'package:dio/dio.dart';

class AuthRemoteDatasource implements IAuthDataSource {
  final ApiService _apiService;

  AuthRemoteDatasource({required ApiService apiService})
    : _apiService = apiService;

  @override
  Future<AuthResponseDto> login(AuthRequestDto requestDto) async {
    try {
      final response = await _apiService.dio.post(
        ApiConstant.login,
        data: requestDto.toJson(),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return AuthResponseDto.fromJSON(response.data);
      } else {
        throw Exception('Login failed: ${response.statusMessage}');
      }
    } on DioException catch (error) {
      throw Exception('Login failed: ${error.message}');
    }
  }

  @override
  Future<AuthResponseDto> register(AuthRequestDto requestDto) async {
    try {
      final response = await _apiService.dio.post(
        ApiConstant.register,
        data: requestDto.toJson(),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return AuthResponseDto.fromJSON(response.data);
      } else {
        throw Exception('User registration failed: ${response.statusMessage}');
      }
    } on DioException catch (error) {
      throw Exception('User registration failed: ${error.message}');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _apiService.dio.post(ApiConstant.logout);
    } on DioException catch (error) {
      throw Exception('Logout failed: ${error.message}');
    }
  }

  @override
  Future<TokenEntity> refreshToken(RefreshTokenRequestDto requestDto) async {
    try {
      final response = await _apiService.dio.post(
        ApiConstant.refreshToken,
        data: requestDto.toJson(),
      );

      if (response.statusCode == 200) {
        return TokenEntity(
          accessToken: response.data['accessToken'],
          refreshToken: response.data['refreshToken'],
        );
      } else {
        throw Exception('Refresh token failed: ${response.statusMessage}');
      }
    } on DioException catch (error) {
      throw Exception('Refresh token failed: ${error.message}');
    }
  }

  @override
  Future<AuthResponseDto> resendVerificationCode(
    ResendVerificationRequestDto requestDto,
  ) async {
    try {
      final response = await _apiService.dio.post(
        ApiConstant.resendVerification,
        data: requestDto.toJson(),
      );

      if (response.statusCode == 200) {
        return AuthResponseDto.fromJSON(response.data);
      } else {
        throw Exception('Resend code failed: ${response.statusMessage}');
      }
    } on DioException catch (error) {
      throw Exception('Resend code failed: ${error.message}');
    }
  }

  @override
  Future<AuthResponseDto> verify(VerifyRequestDto requestDto) async {
    try {
      final response = await _apiService.dio.post(
        ApiConstant.verify,
        data: requestDto.toJson(),
      );

      if (response.statusCode == 200) {
        return AuthResponseDto.fromJSON(response.data);
      } else {
        throw Exception('Verification failed: ${response.statusMessage}');
      }
    } on DioException catch (error) {
      throw Exception('Verification failed: ${error.message}');
    }
  }
}
