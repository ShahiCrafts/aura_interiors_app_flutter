import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String id;
  final String email;
  final String role;
  final bool isVerified;

  const AuthEntity({
    required this.id,
    required this.email,
    required this.role,
    required this.isVerified,
  });

  @override
  List<Object?> get props => [id, email, role, isVerified];
}
