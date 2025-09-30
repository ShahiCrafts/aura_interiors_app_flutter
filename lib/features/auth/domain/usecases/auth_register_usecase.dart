import 'package:aura_interiors/app/usecases/use_case.dart';
import 'package:aura_interiors/core/error/failure.dart';
import 'package:aura_interiors/features/auth/domain/entities/auth_entity.dart';
import 'package:aura_interiors/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RegisterParams extends Equatable {
  final String email;
  final String password;

  const RegisterParams({required this.email, required this.password});
  const RegisterParams.initial() : email = '', password = '';

  @override
  List<Object?> get props => [email, password];
}

class AuthRegisterUsecase
    implements UseCaseWithParams<AuthEntity, RegisterParams> {
  final IAuthRepository _authRepository;

  AuthRegisterUsecase({required IAuthRepository authRepository})
    : _authRepository = authRepository;
  @override
  Future<Either<Failure, AuthEntity>> call(RegisterParams params) async {
    return await _authRepository.register(
      email: params.email,
      password: params.password,
    );
  }
}
