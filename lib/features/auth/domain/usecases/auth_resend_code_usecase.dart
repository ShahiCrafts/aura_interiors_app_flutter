import 'package:aura_interiors/app/usecases/use_case.dart';
import 'package:aura_interiors/core/error/failure.dart';
import 'package:aura_interiors/features/auth/domain/entities/auth_response_entity.dart';
import 'package:aura_interiors/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class ResendCodeParams extends Equatable {
  final String email;

  const ResendCodeParams({required this.email});
  const ResendCodeParams.initital() : email = '';

  @override
  List<Object?> get props => [email];
}

class AuthResendCodeUsecase
    implements UseCaseWithParams<AuthResponseEntity, ResendCodeParams> {
  final IAuthRepository _authRepository;

  const AuthResendCodeUsecase({required IAuthRepository authRepository})
    : _authRepository = authRepository;

  @override
  Future<Either<Failure, AuthResponseEntity>> call(
    ResendCodeParams params,
  ) async {
    return await _authRepository.resendVerificationCode(email: params.email);
  }
}
