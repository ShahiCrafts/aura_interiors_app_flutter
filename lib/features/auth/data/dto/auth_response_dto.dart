import 'package:aura_interiors/features/auth/domain/entities/auth_entity.dart';
import 'package:aura_interiors/features/auth/domain/entities/auth_response_entity.dart';
import 'package:aura_interiors/features/auth/domain/entities/token_entity.dart';
import 'package:equatable/equatable.dart';

class AuthResponseDto extends Equatable {
  final String id;
  final String email;
  final String role;
  final bool isVerified;
  final TokenEntity? tokens;
  final String? message;

  const AuthResponseDto({
    required this.id,
    required this.email,
    required this.role,
    required this.isVerified,
    this.tokens,
    this.message,
  });

  factory AuthResponseDto.fromJSON(Map<String, dynamic> json) {
    return AuthResponseDto(
      id: json['user']?['id'] ?? '',
      email: json['user']?['email'] ?? '',
      role: json['user']?['role'] ?? '',
      isVerified: json['user']?['isVerified'] ?? false,
      tokens: json['tokens'] != null
          ? TokenEntity(
              accessToken: json['tokens']['accessToken'],
              refreshToken: json['tokens']['refreshToken'],
            )
          : null,
      message: json['message'],
    );
  }

  AuthResponseEntity toEntity() {
    return AuthResponseEntity(
      message: message,
      user: AuthEntity(
        id: id,
        email: email,
        role: role,
        isVerified: isVerified,
      ),
      tokens: tokens,
    );
  }

  @override
  List<Object?> get props => [id, email, role, isVerified, tokens];
}
