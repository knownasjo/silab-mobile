part of 'change_password_bloc.dart';

sealed class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object?> get props => [];
}

final class ChangePasswordIdle extends ChangePasswordState {
  const ChangePasswordIdle();
}

final class ChangePasswordSubmitting extends ChangePasswordState {
  const ChangePasswordSubmitting();
}

final class ChangePasswordSucceeded extends ChangePasswordState {
  final String message;

  const ChangePasswordSucceeded(this.message);

  @override
  List<Object?> get props => [message];
}

final class ChangePasswordFailed extends ChangePasswordState {
  final String message;

  const ChangePasswordFailed(this.message);

  @override
  List<Object?> get props => [message];
}
