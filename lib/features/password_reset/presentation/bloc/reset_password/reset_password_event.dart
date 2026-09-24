part of 'reset_password_bloc.dart';

sealed class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object?> get props => [];
}

final class SubmitNewPassword extends ResetPasswordEvent {
  final ResetPasswordModel resetData;

  const SubmitNewPassword(this.resetData);

  @override
  List<Object?> get props => [resetData];
}

final class ResendResetCode extends ResetPasswordEvent {
  final String email;

  const ResendResetCode(this.email);

  @override
  List<Object?> get props => [email];
}
