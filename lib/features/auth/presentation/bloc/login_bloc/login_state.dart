import 'package:aura_interiors/features/auth/presentation/utils/form_status_enum.dart';
import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final FormStatus status;
  final String email;
  final String password;
  final bool rememberMe;
  final bool obscurePassword;
  final String? message;

  const LoginState({
    this.status = FormStatus.initial,
    this.email = '',
    this.password = '',
    this.rememberMe = false,
    this.obscurePassword = false,
    this.message,
  });

  LoginState copyWith({
    FormStatus? status,
    String? email,
    String? password,
    bool? rememberMe,
    bool? obscurePassword,
    String? message,
  }) {
    return LoginState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      rememberMe: rememberMe ?? this.rememberMe,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
    status,
    email,
    password,
    rememberMe,
    obscurePassword,
    message,
  ];
}
