import 'package:aura_interiors/core/error/failure.dart';
import 'package:aura_interiors/features/auth/domain/entities/auth_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IAuthRepository {
  Future<Either<Failure, ({AuthEntity auth, String token})>> login({
    required String email,
    required String password,
  });
  Future<Either<Failure, AuthEntity>> register({
    required String email,
    required String password,
  });
}
