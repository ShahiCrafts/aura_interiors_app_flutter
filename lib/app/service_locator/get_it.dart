import 'package:aura_interiors/core/common/internet_checker_impl.dart';
import 'package:aura_interiors/core/network/api_service.dart';
import 'package:aura_interiors/core/network/auth_service.dart';
import 'package:aura_interiors/core/utils/internet_checker.dart';
import 'package:aura_interiors/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:aura_interiors/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:aura_interiors/features/auth/domain/repositories/auth_repository.dart';
import 'package:aura_interiors/features/auth/domain/usecases/auth_register_usecase.dart';
import 'package:aura_interiors/features/auth/presentation/bloc/signup_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  getIt.registerLazySingleton<InternetChecker>(() => InternetCheckerImpl());
  getIt.registerLazySingleton<ApiService>(() => ApiService(Dio()));
  getIt.registerLazySingleton<AuthService>(() => AuthService());

  _initAuth();
}

void _initAuth() {
  // DATA LAYER DEPENDENCY INJECTION
  getIt.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasource(apiService: getIt<ApiService>()),
  );
  getIt.registerLazySingleton<IAuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: getIt<AuthRemoteDatasource>(),
      internetChecker: getIt<InternetChecker>(),
    ),
  );

  // DOMAIN LAYER DEPENDENCY INJECTION
  getIt.registerLazySingleton<AuthRegisterUsecase>(
    () => AuthRegisterUsecase(authRepository: getIt<IAuthRepository>()),
  );

  // PRESENTATION LAYER (CUBIT/BLOC) DEPENDENCY INJECTION
  getIt.registerFactory<SignupBloc>(
    () => SignupBloc(
      authRegisterUsecase: getIt<AuthRegisterUsecase>(),
      authService: getIt<AuthService>(),
    ),
  );
}
