part of 'registration_verification_bloc.dart';

sealed class RegistrationVerificationState extends Equatable {
  const RegistrationVerificationState();

  @override
  List<Object?> get props => [];
}

final class VerificationIdle extends RegistrationVerificationState {
  const VerificationIdle();
}

final class VerificationSubmitting extends RegistrationVerificationState {
  const VerificationSubmitting();
}

final class VerificationResending extends RegistrationVerificationState {
  const VerificationResending();
}

final class VerificationSucceeded extends RegistrationVerificationState {
  final String message;

  const VerificationSucceeded(this.message);

  @override
  List<Object?> get props => [message];
}

final class VerificationCodeResent extends RegistrationVerificationState {
  final RegistrationEntity registration;

  const VerificationCodeResent(this.registration);

  @override
  List<Object?> get props => [registration];
}

final class VerificationFailed extends RegistrationVerificationState {
  final String message;

  const VerificationFailed(this.message);

  @override
  List<Object?> get props => [message];
}
