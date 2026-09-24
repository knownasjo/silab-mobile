part of 'registration_bloc.dart';

sealed class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object?> get props => [];
}

final class SubmitRegistration extends RegistrationEvent {
  final RegisterModel registerData;

  const SubmitRegistration(this.registerData);

  @override
  List<Object?> get props => [registerData];
}
