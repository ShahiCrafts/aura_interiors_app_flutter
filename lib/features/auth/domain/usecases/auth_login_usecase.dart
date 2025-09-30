import 'package:aura_interiors/app/usecases/use_case.dart';
import 'package:aura_interiors/core/error/failure.dart';
import 'package:aura_interiors/features/auth/domain/entities/auth_entity.dart';
import 'package:aura_interiors/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});
  const LoginParams.initial() : email = '', password = '';

  @override
  List<Object?> get props => [email, password];
}

class AuthLoginUsecase
    implements
        UseCaseWithParams<({AuthEntity auth, String token}), LoginParams> {
  final IAuthRepository _authRepository;

  AuthLoginUsecase({required IAuthRepository authRepository})
    : _authRepository = authRepository;
  @override
  Future<Either<Failure, ({AuthEntity auth, String token})>> call(
    LoginParams params,
  ) async {
    return await _authRepository.login(
      email: params.email,
      password: params.password,
    );
  }
}
