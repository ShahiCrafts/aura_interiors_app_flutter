class VerifyRequestDto {
  final String email;
  final String code;

  const VerifyRequestDto({required this.email, required this.code});

  Map<String, dynamic> toJson() {
    return {'email': email, 'code': code};
  }
}
