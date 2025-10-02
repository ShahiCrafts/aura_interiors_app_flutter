import 'package:aura_interiors/features/auth/data/dto/auth_request_dto.dart';
import 'package:aura_interiors/features/auth/data/dto/auth_response_dto.dart';

abstract class IAuthDataSource {
  Future<AuthResponseDto> register(AuthRequestDto requestDto);
  Future<AuthResponseDto> login(AuthRequestDto requestDto);
}
