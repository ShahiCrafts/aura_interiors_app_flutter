import 'package:aura_interiors/core/network/auth_service.dart';
import 'package:aura_interiors/features/auth/domain/entities/token_entity.dart';
import 'package:aura_interiors/features/auth/domain/usecases/auth_resend_code_usecase.dart';
import 'package:aura_interiors/features/auth/domain/usecases/auth_verify_usecase.dart';
import 'package:aura_interiors/features/auth/presentation/bloc/otp_code_event.dart';
import 'package:aura_interiors/features/auth/presentation/bloc/otp_code_state.dart';
import 'package:aura_interiors/features/auth/presentation/utils/form_status_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpCodeBloc extends Bloc<OtpCodeEvent, OtpCodeState> {
  final AuthVerifyUsecase _verifyCodeUsecase;
  final AuthResendCodeUsecase _resendCodeUsecase;
  final AuthService _authService;

  OtpCodeBloc({
    required AuthVerifyUsecase verifyCodeUsecase,
    required AuthResendCodeUsecase resendCodeUsecase,
    required AuthService authService,
  }) : _verifyCodeUsecase = verifyCodeUsecase,
       _resendCodeUsecase = resendCodeUsecase,
       _authService = authService,
       super(const OtpCodeState()) {
    on<OtpDigitChanged>(_onOtpDigitChanged);
    on<OtpVerifyRequested>(_onOtpVerifyRequested);
    on<OtpResendRequested>(_onOtpResendRequested);
  }

  void _onOtpDigitChanged(OtpDigitChanged event, Emitter<OtpCodeState> emit) {
    final updatedDigits = List<String>.from(state.otpDigits);
    updatedDigits[event.index] = event.value;

    emit(state.copyWith(otpDigits: updatedDigits));
  }

  Future<void> _onOtpVerifyRequested(
    OtpVerifyRequested event,
    Emitter<OtpCodeState> emit,
  ) async {
    if (state.code.length != 6 || event.email.isEmpty) return;

    emit(state.copyWith(status: FormStatus.submitting, message: null));

    final params = VerifyParams(email: event.email, code: event.code);
    final result = await _verifyCodeUsecase(params);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: FormStatus.failure,
          otpDigits: List.filled(6, ''),
          message: failure.errorMessage,
        ),
      ),
      (response) async {
        final tokens = response.tokens;
        if (tokens != null) {
          await _authService.saveTokens(
            TokenEntity(
              accessToken: tokens.accessToken,
              refreshToken: tokens.refreshToken,
            ),
          );
        }
        emit(
          state.copyWith(
            status: FormStatus.success,
            message: 'Email verified success',
          ),
        );
      },
    );
  }

  Future<void> _onOtpResendRequested(
    OtpResendRequested event,
    Emitter<OtpCodeState> emit,
  ) async {
    if (event.email.isEmpty) return;

    emit(state.copyWith(status: FormStatus.submitting, message: null));

    final params = ResendCodeParams(email: event.email);
    final result = await _resendCodeUsecase(params);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: FormStatus.failure,
          message: failure.errorMessage,
        ),
      ),
      (response) => emit(
        state.copyWith(
          status: FormStatus.success,
          message: 'New code sent successfully!',
        ),
      ),
    );
  }
}
