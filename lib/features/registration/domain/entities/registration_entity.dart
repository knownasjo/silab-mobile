import 'package:equatable/equatable.dart';

class RegistrationEntity extends Equatable {
  final String email;
  final String nim;
  final int expiresIn;
  final int resendIn;

  const RegistrationEntity({
    required this.email,
    required this.nim,
    this.expiresIn = 600,
    this.resendIn = 60,
  });

  factory RegistrationEntity.fromJson(Map<String, dynamic> json) =>
      RegistrationEntity(
        email: json['email'] is String ? json['email'] as String : '',
        nim: json['nim'] is String ? json['nim'] as String : '',
        expiresIn: json['expiresIn'] is num
            ? (json['expiresIn'] as num).toInt()
            : 600,
        resendIn:
            json['resendIn'] is num ? (json['resendIn'] as num).toInt() : 60,
      );

  @override
  List<Object?> get props => [email, nim, expiresIn, resendIn];
}
