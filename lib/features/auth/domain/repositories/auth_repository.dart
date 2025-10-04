import 'package:aura_interiors/core/error/failure.dart';
import 'package:aura_interiors/features/auth/domain/entities/auth_response_entity.dart';
import 'package:aura_interiors/features/auth/domain/entities/token_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IAuthRepository {
  Future<Either<Failure, AuthResponseEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, AuthResponseEntity>> register({
    required String email,
    required String password,
  });

  Future<Either<Failure, AuthResponseEntity>> verify({
    required String email,
    required String code,
  });

  Future<Either<Failure, AuthResponseEntity>> resendVerificationCode({
    required String email,
  });

  Future<Either<Failure, TokenEntity>> refreshToken({
    required String refreshToken,
  });

  Future<Either<Failure, void>> logout();
}
