import 'package:aura_interiors/app/usecases/use_case.dart';
import 'package:aura_interiors/core/error/failure.dart';
import 'package:aura_interiors/features/auth/domain/entities/token_entity.dart';
import 'package:aura_interiors/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RefreshTokenParams extends Equatable {
  final String refreshToken;

  const RefreshTokenParams({required this.refreshToken});
  const RefreshTokenParams.initial() : refreshToken = '';

  @override
  List<Object?> get props => throw UnimplementedError();
}

class AuthRefreshTokenUsecase
    implements UseCaseWithParams<TokenEntity, RefreshTokenParams> {
  final IAuthRepository _authRepository;
  const AuthRefreshTokenUsecase({required IAuthRepository authRepository})
    : _authRepository = authRepository;

  @override
  Future<Either<Failure, TokenEntity>> call(RefreshTokenParams params) async {
    return await _authRepository.refreshToken(
      refreshToken: params.refreshToken,
    );
  }
}
