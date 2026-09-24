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
        expiresIn: json['expires_in'] is num
            ? (json['expires_in'] as num).toInt()
            : 600,
        resendIn:
            json['resend_in'] is num ? (json['resend_in'] as num).toInt() : 60,
      );

  @override
  List<Object?> get props => [email, expiresIn, resendIn];
}
