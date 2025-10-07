import 'package:equatable/equatable.dart';

abstract class OtpCodeEvent extends Equatable {
  const OtpCodeEvent();

  @override
  List<Object?> get props => [];
}

class OtpDigitChanged extends OtpCodeEvent {
  final int index;
  final String value;

  const OtpDigitChanged(this.index, this.value);

  @override
  List<Object?> get props => [index, value];
}

class OtpVerifyRequested extends OtpCodeEvent {
  final String email;
  final String code;

  const OtpVerifyRequested(this.email, this.code);

  @override
  List<Object?> get props => [email, code];
}

class OtpResendRequested extends OtpCodeEvent {
  final String email;

  const OtpResendRequested(this.email);
}
