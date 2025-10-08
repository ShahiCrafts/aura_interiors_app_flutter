import 'package:aura_interiors/features/auth/domain/usecases/auth_register_usecase.dart';
import 'package:aura_interiors/features/auth/presentation/bloc/signup_bloc/signup_event.dart';
import 'package:aura_interiors/features/auth/presentation/bloc/signup_bloc/signup_state.dart';
import 'package:aura_interiors/features/auth/presentation/utils/form_status_enum.dart';
import 'package:bloc/bloc.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthRegisterUsecase _authRegisterUsecase;

  SignupBloc({required AuthRegisterUsecase authRegisterUsecase})
    : _authRegisterUsecase = authRegisterUsecase,
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

    await Future.delayed(const Duration(seconds: 2));

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
            message: failure.errorMessage,
          ),
        );
      },
      (authResponseEntity) async {
        final message =
            authResponseEntity.message ?? 'Account created successfully!';
        emit(
          state.copyWith(
            email: event.email,
            status: FormStatus.success,
            message: message,
          ),
        );
      },
    );
  }
}
