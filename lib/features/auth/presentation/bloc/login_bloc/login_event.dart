import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class RememberMeToggled extends LoginEvent {
  final bool value;

  const RememberMeToggled(this.value);
  @override
  List<Object?> get props => [value];
}

class PasswordVisibilityToggled extends LoginEvent {}

class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;

  const LoginSubmitted(this.email, this.password);
  @override
  List<Object?> get props => [email, password];
}
