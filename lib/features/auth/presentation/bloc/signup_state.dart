import 'package:aura_interiors/features/auth/presentation/utils/form_status_enum.dart';
import 'package:equatable/equatable.dart';

class SignupState extends Equatable {
  final FormStatus status;
  final String email;
  final String password;
  final bool obscurePassword;
  final bool agreeToPolicy;
  final String? message;

  const SignupState({
    this.status = FormStatus.initial,
    this.email = '',
    this.password = '',
    this.agreeToPolicy = false,
    this.obscurePassword = true,
    this.message,
  });

  SignupState copyWith({
    FormStatus? status,
    String? email,
    String? password,
    bool? obscurePassword,
    bool? agreeToPolicy,
    String? message,
  }) {
    return SignupState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      agreeToPolicy: agreeToPolicy ?? this.agreeToPolicy,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
    status,
    email,
    password,
    obscurePassword,
    agreeToPolicy,
    message,
  ];
}
