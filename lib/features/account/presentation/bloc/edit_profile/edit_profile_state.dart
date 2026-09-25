part of 'edit_profile_bloc.dart';

sealed class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object?> get props => [];
}

final class EditProfileIdle extends EditProfileState {
  const EditProfileIdle();
}

final class EditProfileSubmitting extends EditProfileState {
  const EditProfileSubmitting();
}

final class EditProfileSucceeded extends EditProfileState {
  final String message;

  const EditProfileSucceeded(this.message);

  @override
  List<Object?> get props => [message];
}

final class EditProfileFailed extends EditProfileState {
  final String message;

  const EditProfileFailed(this.message);

  @override
  List<Object?> get props => [message];
}
