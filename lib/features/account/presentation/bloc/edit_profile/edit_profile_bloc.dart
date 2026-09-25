import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:silab/features/account/domain/usecases/update_profile_usecase.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final UpdateProfileUsecase _updateProfileUsecase;

  EditProfileBloc(this._updateProfileUsecase)
      : super(const EditProfileIdle()) {
    on<SubmitProfile>(_onSubmitProfile);
  }

  Future<void> _onSubmitProfile(
    SubmitProfile event,
    Emitter<EditProfileState> emit,
  ) async {
    if (state is EditProfileSubmitting || state is EditProfileSucceeded) {
      return;
    }

    emit(const EditProfileSubmitting());

    final result = await _updateProfileUsecase(event.fullname);

    result.fold(
      (failure) => emit(EditProfileFailed(failure.message)),
      (message) => emit(EditProfileSucceeded(message)),
    );
  }
}
