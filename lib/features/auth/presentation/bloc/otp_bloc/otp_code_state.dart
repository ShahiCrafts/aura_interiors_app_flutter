import 'package:aura_interiors/features/auth/presentation/utils/form_status_enum.dart';
import 'package:equatable/equatable.dart';

class OtpCodeState extends Equatable {
  final List<String> otpDigits;
  final String email;
  final FormStatus status;
  final String? message;

  const OtpCodeState({
    this.otpDigits = const ['', '', '', '', '', ''],
    this.email = '',
    this.status = FormStatus.initial,
    this.message,
  });

  String get code => otpDigits.join();

  OtpCodeState copyWith({
    List<String>? otpDigits,
    String? email,
    FormStatus? status,
    String? message,
  }) {
    return OtpCodeState(
      otpDigits: otpDigits ?? this.otpDigits,
      email: email ?? this.email,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [otpDigits, email, status, message];
}
