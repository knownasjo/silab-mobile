part of 'registration_verification_bloc.dart';

sealed class RegistrationVerificationEvent extends Equatable {
  const RegistrationVerificationEvent();

  @override
  List<Object?> get props => [];
}

final class SubmitVerificationCode extends RegistrationVerificationEvent {
  final String email;
  final String code;

  const SubmitVerificationCode({required this.email, required this.code});

  @override
  List<Object?> get props => [email, code];
}

final class ResendVerificationCode extends RegistrationVerificationEvent {
  final String email;

  const ResendVerificationCode(this.email);

  @override
  List<Object?> get props => [email];
}
