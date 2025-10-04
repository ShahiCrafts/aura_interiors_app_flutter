import 'package:aura_interiors/core/error/failure.dart';
import 'package:aura_interiors/core/utils/internet_checker.dart';
import 'package:aura_interiors/features/auth/data/data_sources/auth_data_source.dart';
import 'package:aura_interiors/features/auth/data/dto/auth_request_dto.dart';
import 'package:aura_interiors/features/auth/data/dto/refresh_token_request_dto.dart';
import 'package:aura_interiors/features/auth/data/dto/resend_verification_request_dto.dart';
import 'package:aura_interiors/features/auth/data/dto/verify_request_dto.dart';
import 'package:aura_interiors/features/auth/domain/entities/auth_response_entity.dart';
import 'package:aura_interiors/features/auth/domain/entities/token_entity.dart';
import 'package:aura_interiors/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final IAuthDataSource _remoteDataSource;
  final InternetChecker _internetChecker;

  AuthRepositoryImpl({
    required IAuthDataSource remoteDataSource,
    required InternetChecker internetChecker,
  }) : _remoteDataSource = remoteDataSource,
       _internetChecker = internetChecker;

  @override
  Future<Either<Failure, AuthResponseEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final isOnline = await _internetChecker.isConnected();
      if (!isOnline) {
        return Left(NetworkFailure(errorMessage: 'No internet connection'));
      }
      final requestDto = AuthRequestDto(email: email, password: password);
      final responseDto = await _remoteDataSource.login(requestDto);

      return Right(responseDto.toEntity());
    } catch (error) {
      return Left(ServerFailure(errorMessage: error.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResponseEntity>> register({
    required String email,
    required String password,
  }) async {
    try {
      final isOnline = await _internetChecker.isConnected();
      if (!isOnline) {
        return Left(NetworkFailure(errorMessage: 'No internet connection'));
      }
      final requestDto = AuthRequestDto(email: email, password: password);
      final responseDto = await _remoteDataSource.register(requestDto);

      return Right(responseDto.toEntity());
    } catch (error) {
      return Left(ServerFailure(errorMessage: error.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final isOnline = await _internetChecker.isConnected();
      if (!isOnline) {
        return Left(NetworkFailure(errorMessage: 'No internet connection'));
      }

      await _remoteDataSource.logout();
      return const Right(null);
    } catch (error) {
      return Left(ServerFailure(errorMessage: error.toString()));
    }
  }

  @override
  Future<Either<Failure, TokenEntity>> refreshToken({
    required String refreshToken,
  }) async {
    try {
      final isOnline = await _internetChecker.isConnected();
      if (!isOnline) {
        return Left(NetworkFailure(errorMessage: 'No internet connection'));
      }

      final requestDto = RefreshTokenRequestDto(refreshToken: refreshToken);
      final tokenEntity = await _remoteDataSource.refreshToken(requestDto);

      return Right(tokenEntity);
    } catch (error) {
      return Left(ServerFailure(errorMessage: error.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResponseEntity>> resendVerificationCode({
    required String email,
  }) async {
    try {
      final isOnline = await _internetChecker.isConnected();
      if (!isOnline) {
        return Left(NetworkFailure(errorMessage: 'No internet connection'));
      }

      final requestDto = ResendVerificationRequestDto(email: email);
      final responseDto = await _remoteDataSource.resendVerificationCode(
        requestDto,
      );

      return Right(responseDto.toEntity());
    } catch (error) {
      return Left(ServerFailure(errorMessage: error.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResponseEntity>> verify({
    required String email,
    required String code,
  }) async {
    try {
      final isOnline = await _internetChecker.isConnected();
      if (!isOnline) {
        return Left(NetworkFailure(errorMessage: 'No internet connection'));
      }

      final requestDto = VerifyRequestDto(email: email, code: code);
      final responseDto = await _remoteDataSource.verify(requestDto);

      return Right(responseDto.toEntity());
    } catch (error) {
      return Left(ServerFailure(errorMessage: error.toString()));
    }
  }
}
