part of 'reset_password_bloc.dart';

sealed class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object?> get props => [];
}

final class ResetPasswordIdle extends ResetPasswordState {
  const ResetPasswordIdle();
}

final class ResetPasswordSubmitting extends ResetPasswordState {
  const ResetPasswordSubmitting();
}

final class ResetPasswordResending extends ResetPasswordState {
  const ResetPasswordResending();
}

final class ResetPasswordSucceeded extends ResetPasswordState {
  final String message;

  const ResetPasswordSucceeded(this.message);

  @override
  List<Object?> get props => [message];
}

final class ResetPasswordCodeResent extends ResetPasswordState {
  final PasswordResetEntity reset;

  const ResetPasswordCodeResent(this.reset);

  @override
  List<Object?> get props => [reset];
}

final class ResetPasswordFailed extends ResetPasswordState {
  final String message;

  const ResetPasswordFailed(this.message);

  @override
  List<Object?> get props => [message];
}
