class ChangePasswordModel {
  final String oldPassword;
  final String password;
  final String confirmPassword;

  const ChangePasswordModel({
    required this.oldPassword,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() => {
        'oldPassword': oldPassword,
        'password': password,
        'confirmPassword': confirmPassword,
      };
}
