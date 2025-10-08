import 'package:aura_interiors/core/common/internet_checker_impl.dart';
import 'package:aura_interiors/core/network/api_service.dart';
import 'package:aura_interiors/core/network/auth_service.dart';
import 'package:aura_interiors/core/utils/internet_checker.dart';
import 'package:aura_interiors/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:aura_interiors/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:aura_interiors/features/auth/domain/repositories/auth_repository.dart';
import 'package:aura_interiors/features/auth/domain/usecases/auth_login_usecase.dart';
import 'package:aura_interiors/features/auth/domain/usecases/auth_register_usecase.dart';
import 'package:aura_interiors/features/auth/domain/usecases/auth_resend_code_usecase.dart';
import 'package:aura_interiors/features/auth/domain/usecases/auth_verify_usecase.dart';
import 'package:aura_interiors/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:aura_interiors/features/auth/presentation/bloc/otp_bloc/otp_code_bloc.dart';
import 'package:aura_interiors/features/auth/presentation/bloc/signup_bloc/signup_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  serviceLocator.registerLazySingleton<InternetChecker>(
    () => InternetCheckerImpl(),
  );
  serviceLocator.registerLazySingleton<ApiService>(() => ApiService(Dio()));
  serviceLocator.registerLazySingleton<AuthService>(() => AuthService());

  _initAuth();
}

void _initAuth() {
  // DATA LAYER DEPENDENCY INJECTION
  serviceLocator.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasource(apiService: serviceLocator<ApiService>()),
  );
  serviceLocator.registerLazySingleton<IAuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: serviceLocator<AuthRemoteDatasource>(),
      internetChecker: serviceLocator<InternetChecker>(),
    ),
  );

  // DOMAIN LAYER DEPENDENCY INJECTION
  serviceLocator.registerFactory<AuthRegisterUsecase>(
    () =>
        AuthRegisterUsecase(authRepository: serviceLocator<IAuthRepository>()),
  );
  serviceLocator.registerFactory<AuthLoginUsecase>(
    () => AuthLoginUsecase(authRepository: serviceLocator<IAuthRepository>()),
  );
  serviceLocator.registerFactory(
    () => AuthVerifyUsecase(authRepository: serviceLocator<IAuthRepository>()),
  );
  serviceLocator.registerFactory(
    () => AuthResendCodeUsecase(
      authRepository: serviceLocator<IAuthRepository>(),
    ),
  );

  // PRESENTATION LAYER (CUBIT/BLOC) DEPENDENCY INJECTION
  serviceLocator.registerLazySingleton<SignupBloc>(
    () =>
        SignupBloc(authRegisterUsecase: serviceLocator<AuthRegisterUsecase>()),
  );
  serviceLocator.registerFactory<LoginBloc>(
    () => LoginBloc(
      authService: serviceLocator<AuthService>(),
      authLoginUsecase: serviceLocator<AuthLoginUsecase>(),
    ),
  );
  serviceLocator.registerFactory(
    () => OtpCodeBloc(
      verifyCodeUsecase: serviceLocator<AuthVerifyUsecase>(),
      resendCodeUsecase: serviceLocator<AuthResendCodeUsecase>(),
      authService: serviceLocator<AuthService>(),
    ),
  );
}
