import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String id;
  final String email;
  final String role;
  final bool isVerified;
  final String? token;

  const AuthEntity({
    required this.id,
    required this.email,
    required this.role,
    required this.isVerified,
    this.token,
  });

  @override
  List<Object?> get props => [id, email, role, isVerified, token];
}
