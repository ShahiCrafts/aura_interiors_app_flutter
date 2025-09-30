import 'package:aura_interiors/features/auth/domain/entities/auth_entity.dart';
import 'package:equatable/equatable.dart';

class AuthResponseDto extends Equatable {
  final String id;
  final String email;
  final String role;
  final bool isVerified;
  final String? token;

  const AuthResponseDto({
    required this.id,
    required this.email,
    required this.role,
    required this.isVerified,
    this.token,
  });

  factory AuthResponseDto.fromJSON(Map<String, dynamic> json) {
    return AuthResponseDto(
      id: json['_id'],
      email: json['email'],
      role: json['role'],
      isVerified: json['isVerified'],
      token: json['token'],
    );
  }

  AuthEntity toEntity() {
    return AuthEntity(
      id: id,
      email: email,
      role: role,
      isVerified: isVerified,
      token: token,
    );
  }

  @override
  List<Object?> get props => [id, email, role, isVerified, token];
}
