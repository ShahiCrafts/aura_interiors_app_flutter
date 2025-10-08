import 'package:aura_interiors/features/auth/domain/entities/token_entity.dart';
import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String id;
  final String email;
  final String role;
  final bool isVerified;
  final TokenEntity? tokens;

  const AuthEntity({
    required this.id,
    required this.email,
    required this.role,
    required this.isVerified,
    this.tokens,
  });

  @override
  List<Object?> get props => [id, email, role, isVerified, tokens];
}
