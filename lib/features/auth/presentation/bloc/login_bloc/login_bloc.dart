import 'package:aura_interiors/core/network/auth_service.dart';
import 'package:aura_interiors/features/auth/domain/entities/token_entity.dart';
import 'package:aura_interiors/features/auth/domain/usecases/auth_login_usecase.dart';
import 'package:aura_interiors/features/auth/presentation/bloc/login_bloc/login_event.dart';
import 'package:aura_interiors/features/auth/presentation/bloc/login_bloc/login_state.dart';
import 'package:aura_interiors/features/auth/presentation/utils/form_status_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthService _authService;
  final AuthLoginUsecase _authLoginUsecase;

  LoginBloc({
    required AuthService authService,
    required AuthLoginUsecase authLoginUsecase,
  }) : _authService = authService,
       _authLoginUsecase = authLoginUsecase,
       super(const LoginState()) {
    on<PasswordVisibilityToggled>(_onPasswordVisibilityToggled);
    on<RememberMeToggled>(_onRememberMeToggled);
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  void _onPasswordVisibilityToggled(
    PasswordVisibilityToggled event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void _onRememberMeToggled(RememberMeToggled event, Emitter<LoginState> emit) {
    emit(state.copyWith(rememberMe: event.value));
  }

  void _onLoginSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: FormStatus.submitting, message: ''));

    await Future.delayed(const Duration(seconds: 2));

    final params = LoginParams(
      email: event.email.trim(),
      password: event.password.trim(),
    );

    final result = await _authLoginUsecase(params);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: FormStatus.failure,
            message: failure.errorMessage,
          ),
        );
      },
      (response) async {
        final tokens = response.user!.tokens;
        if (tokens != null) {
          await _authService.saveTokens(
            TokenEntity(
              accessToken: tokens.accessToken,
              refreshToken: tokens.refreshToken,
            ),
          );
        }
        final message = response.message ?? 'Login Successful';
        emit(state.copyWith(status: FormStatus.success, message: message));
      },
    );
  }
}
