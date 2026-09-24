class RegisterModel {
  final String email;
  final String fullname;
  final String password;
  final String confirmPassword;

  const RegisterModel({
    required this.email,
    required this.fullname,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'fullname': fullname,
        'password': password,
        'confirmPassword': confirmPassword,
      };
}
