import 'package:aura_interiors/core/network/auth_service.dart';
import 'package:aura_interiors/features/auth/domain/usecases/auth_register_usecase.dart';
import 'package:aura_interiors/features/auth/presentation/bloc/signup_event.dart';
import 'package:aura_interiors/features/auth/presentation/bloc/signup_state.dart';
import 'package:aura_interiors/features/auth/presentation/utils/form_status_enum.dart';
import 'package:bloc/bloc.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthRegisterUsecase _authRegisterUsecase;
  final AuthService _authService;

  SignupBloc({
    required AuthRegisterUsecase authRegisterUsecase,
    required AuthService authService,
  }) : _authRegisterUsecase = authRegisterUsecase,
       _authService = authService,
       super(const SignupState()) {
    on<PasswordVisibilityToggled>(_onPasswordVisibilityToggled);
    on<PrivacyPolicyToggled>(_onPrivacyPolicyToggled);
    on<SignupSubmitted>(_onSignupSubmitted);
  }

  void _onPasswordVisibilityToggled(
    PasswordVisibilityToggled event,
    Emitter<SignupState> emit,
  ) {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void _onPrivacyPolicyToggled(
    PrivacyPolicyToggled event,
    Emitter<SignupState> emit,
  ) {
    emit(state.copyWith(agreeToPolicy: event.value));
  }

  void _onSignupSubmitted(
    SignupSubmitted event,
    Emitter<SignupState> emit,
  ) async {
    if (!state.agreeToPolicy) {
      emit(
        state.copyWith(
          status: FormStatus.failure,
          message: 'You must agree to the Privacy Policy & Terms.',
        ),
      );
      return;
    }

    emit(state.copyWith(status: FormStatus.submitting, message: ''));

    final params = RegisterParams(
      email: event.email.trim(),
      password: event.password.trim(),
    );

    final result = await _authRegisterUsecase(params);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: FormStatus.failure,
            message: failure.toString(),
          ),
        );
      },
      (authEntity) async {
        final token = authEntity.token;

        if (token != null) {
          await _authService.signIn(token);
        }
        emit(
          state.copyWith(
            status: FormStatus.success,
            message: 'Account created successfully!',
          ),
        );
      },
    );
  }
}
