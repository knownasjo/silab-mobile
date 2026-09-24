class ResetPasswordModel {
  final String email;
  final String code;
  final String password;
  final String confirmPassword;

  const ResetPasswordModel({
    required this.email,
    required this.code,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'code': code,
        'password': password,
        'confirmPassword': confirmPassword,
      };
}
