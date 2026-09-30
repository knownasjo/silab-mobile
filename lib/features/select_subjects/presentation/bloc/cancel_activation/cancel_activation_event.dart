part of 'cancel_activation_bloc.dart';

sealed class CancelActivationEvent extends Equatable {
  const CancelActivationEvent();

  @override
  List<Object?> get props => [];
}

final class CancelActivation extends CancelActivationEvent {
  final String activationId;

  const CancelActivation(this.activationId);

  @override
  List<Object?> get props => [activationId];
}
