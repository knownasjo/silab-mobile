part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object?> get props => [];
}

final class ForgotPasswordInitial extends ForgotPasswordState {
  const ForgotPasswordInitial();
}

final class ForgotPasswordSubmitting extends ForgotPasswordState {
  const ForgotPasswordSubmitting();
}

final class ForgotPasswordCodeSent extends ForgotPasswordState {
  final PasswordResetEntity reset;

  const ForgotPasswordCodeSent(this.reset);

  @override
  List<Object?> get props => [reset];
}

final class ForgotPasswordUnverified extends ForgotPasswordState {
  final String email;
  final String message;

  const ForgotPasswordUnverified({required this.email, required this.message});

  @override
  List<Object?> get props => [email, message];
}

final class ForgotPasswordFailed extends ForgotPasswordState {
  final String message;

  const ForgotPasswordFailed(this.message);

  @override
  List<Object?> get props => [message];
}
