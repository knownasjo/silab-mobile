part of 'change_password_bloc.dart';

sealed class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object?> get props => [];
}

final class SubmitPasswordChange extends ChangePasswordEvent {
  final ChangePasswordModel passwordData;

  const SubmitPasswordChange(this.passwordData);

  @override
  List<Object?> get props => [passwordData];
}
