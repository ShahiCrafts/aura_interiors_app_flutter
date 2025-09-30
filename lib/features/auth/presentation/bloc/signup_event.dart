import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object?> get props => [];
}

class PrivacyPolicyToggled extends SignupEvent {
  final bool value;

  const PrivacyPolicyToggled(this.value);

  @override
  List<Object?> get props => [value];
}

class PasswordVisibilityToggled extends SignupEvent {}

class SignupSubmitted extends SignupEvent {
  final String email;
  final String password;

  const SignupSubmitted(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}
