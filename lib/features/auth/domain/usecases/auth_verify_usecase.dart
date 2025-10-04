import 'package:aura_interiors/app/usecases/use_case.dart';
import 'package:aura_interiors/core/error/failure.dart';
import 'package:aura_interiors/features/auth/domain/entities/auth_response_entity.dart';
import 'package:aura_interiors/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class VerifyParams extends Equatable {
  final String email;
  final String code;

  const VerifyParams({required this.email, required this.code});
  const VerifyParams.initial() : email = '', code = '';

  @override
  List<Object?> get props => [email, code];
}

class AuthVerifyUsecase
    implements UseCaseWithParams<AuthResponseEntity, VerifyParams> {
  final IAuthRepository _authRepository;

  AuthVerifyUsecase({required IAuthRepository authRepository})
    : _authRepository = authRepository;

  @override
  Future<Either<Failure, AuthResponseEntity>> call(VerifyParams params) async {
    return await _authRepository.verify(email: params.email, code: params.code);
  }
}
