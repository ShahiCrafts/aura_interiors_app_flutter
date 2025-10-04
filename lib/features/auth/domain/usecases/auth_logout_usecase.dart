import 'package:aura_interiors/app/usecases/use_case.dart';
import 'package:aura_interiors/core/error/failure.dart';
import 'package:aura_interiors/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthLogoutUsecase implements UseCaseWithoutParams<void> {
  final IAuthRepository _authRepository;
  const AuthLogoutUsecase({required IAuthRepository authRepository})
    : _authRepository = authRepository;

  @override
  Future<Either<Failure, void>> call() async {
    return await _authRepository.logout();
  }
}
