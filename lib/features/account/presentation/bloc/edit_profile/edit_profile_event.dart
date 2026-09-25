part of 'edit_profile_bloc.dart';

sealed class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object?> get props => [];
}

final class SubmitProfile extends EditProfileEvent {
  final String fullname;

  const SubmitProfile(this.fullname);

  @override
  List<Object?> get props => [fullname];
}
