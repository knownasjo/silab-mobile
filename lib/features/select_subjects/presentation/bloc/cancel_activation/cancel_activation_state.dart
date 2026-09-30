part of 'cancel_activation_bloc.dart';

sealed class CancelActivationState extends Equatable {
  const CancelActivationState();

  @override
  List<Object?> get props => [];
}

final class CancelActivationIdle extends CancelActivationState {
  const CancelActivationIdle();
}

final class CancelActivationSubmitting extends CancelActivationState {
  final String activationId;

  const CancelActivationSubmitting(this.activationId);

  @override
  List<Object?> get props => [activationId];
}

final class CancelActivationSucceeded extends CancelActivationState {
  final String message;

  const CancelActivationSucceeded(this.message);

  @override
  List<Object?> get props => [message];
}

final class CancelActivationFailed extends CancelActivationState {
  final String message;

  const CancelActivationFailed(this.message);

  @override
  List<Object?> get props => [message];
}
