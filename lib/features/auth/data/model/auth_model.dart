import 'package:aura_interiors/features/auth/data/dto/auth_response_dto.dart';
import 'package:aura_interiors/features/auth/domain/entities/auth_entity.dart';

class AuthModel extends AuthEntity {
  const AuthModel({
    required super.id,
    required super.email,
    required super.role,
    required super.isVerified,
  });

  factory AuthModel.fromDto(AuthResponseDto dto) {
    return AuthModel(
      id: dto.id,
      email: dto.email,
      role: dto.role,
      isVerified: dto.isVerified,
    );
  }
}
