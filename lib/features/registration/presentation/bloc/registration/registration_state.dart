part of 'registration_bloc.dart';

sealed class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object?> get props => [];
}

final class RegistrationInitial extends RegistrationState {
  const RegistrationInitial();
}

final class RegistrationSubmitting extends RegistrationState {
  const RegistrationSubmitting();
}

final class RegistrationCodeSent extends RegistrationState {
  final RegistrationEntity registration;

  const RegistrationCodeSent(this.registration);

  @override
  List<Object?> get props => [registration];
}

final class RegistrationFailed extends RegistrationState {
  final String message;

  const RegistrationFailed(this.message);

  @override
  List<Object?> get props => [message];
}
