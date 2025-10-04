import 'package:aura_interiors/features/auth/domain/entities/auth_entity.dart';
import 'package:aura_interiors/features/auth/domain/entities/token_entity.dart';

class AuthResponseEntity {
  final String? message;
  final AuthEntity? user;
  final TokenEntity? tokens;

  const AuthResponseEntity({
    this.message,
    this.user,
    this.tokens,
  });
}
