import 'package:aura_interiors/features/auth/data/dto/auth_request_dto.dart';
import 'package:aura_interiors/features/auth/data/dto/auth_response_dto.dart';
import 'package:aura_interiors/features/auth/data/dto/refresh_token_request_dto.dart';
import 'package:aura_interiors/features/auth/data/dto/resend_verification_request_dto.dart';
import 'package:aura_interiors/features/auth/data/dto/verify_request_dto.dart';
import 'package:aura_interiors/features/auth/domain/entities/token_entity.dart';

abstract class IAuthDataSource {
  Future<AuthResponseDto> register(AuthRequestDto requestDto);
  Future<AuthResponseDto> login(AuthRequestDto requestDto);
  Future<AuthResponseDto> verify(VerifyRequestDto requestDto);
  Future<AuthResponseDto> resendVerificationCode(
    ResendVerificationRequestDto requestDto,
  );
  Future<TokenEntity> refreshToken(RefreshTokenRequestDto requestDto);
  Future<void> logout();
}
