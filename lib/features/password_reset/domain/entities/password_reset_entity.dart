import 'package:equatable/equatable.dart';

class PasswordResetEntity extends Equatable {
  final String email;
  final int expiresIn;
  final int resendIn;

  const PasswordResetEntity({
    required this.email,
    this.expiresIn = 600,
    this.resendIn = 60,
  });

  factory PasswordResetEntity.fromJson(Map<String, dynamic> json) =>
      PasswordResetEntity(
        email: json['email'] is String ? json['email'] as String : '',
        expiresIn: json['expiresIn'] is num
            ? (json['expiresIn'] as num).toInt()
            : 600,
        resendIn:
            json['resendIn'] is num ? (json['resendIn'] as num).toInt() : 60,
      );

  @override
  List<Object?> get props => [email, expiresIn, resendIn];
}
