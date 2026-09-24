part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object?> get props => [];
}

final class SubmitForgotPassword extends ForgotPasswordEvent {
  final String email;

  const SubmitForgotPassword(this.email);

  @override
  List<Object?> get props => [email];
}
