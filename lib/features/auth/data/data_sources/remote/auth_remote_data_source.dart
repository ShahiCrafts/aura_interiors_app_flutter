import 'package:aura_interiors/app/constant/api/api_constant.dart';
import 'package:aura_interiors/core/network/api_service.dart';
import 'package:aura_interiors/features/auth/data/data_sources/auth_data_source.dart';
import 'package:aura_interiors/features/auth/data/dto/auth_request_dto.dart';
import 'package:aura_interiors/features/auth/data/dto/auth_response_dto.dart';
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
    } catch (error) {
      throw Exception('Login failed: $error');
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
        return AuthResponseDto.fromJSON(response.data['user']);
      } else {
        throw Exception('User registration failed: ${response.statusMessage}');
      }
    } on DioException catch (error) {
      throw Exception('User registration failed: ${error.message}');
    } catch (error) {
      throw Exception('User registration failed: $error');
    }
  }
}
