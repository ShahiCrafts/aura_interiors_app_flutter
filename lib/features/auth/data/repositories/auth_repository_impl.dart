import 'package:aura_interiors/core/error/failure.dart';
import 'package:aura_interiors/core/utils/internet_checker.dart';
import 'package:aura_interiors/features/auth/data/data_sources/auth_data_source.dart';
import 'package:aura_interiors/features/auth/data/dto/auth_request_dto.dart';
import 'package:aura_interiors/features/auth/domain/entities/auth_entity.dart';
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
  Future<Either<Failure, ({AuthEntity auth, String token})>> login({
    required String email,
    required String password,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AuthEntity>> register({
    required String email,
    required String password,
  }) async {
    try {
      // final isOnline = await _internetChecker.isConnected();
      // if (!isOnline) {
      //   return Left(NetworkFailure(errorMessage: 'No internet connection'));
      // }
      // Prepare DTO
      final requestDto = AuthRequestDto(email: email, password: password);
      // Call remote datasource
      final responseDto = await _remoteDataSource.register(requestDto);

      final entity = AuthEntity(
        id: responseDto.id,
        email: responseDto.email,
        role: responseDto.role,
        isVerified: responseDto.isVerified,
      );

      return Right(entity);
    } catch (error) {
      return Left(ServerFailure(errorMessage: error.toString()));
    }
  }
}
