import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:silab/features/account/data/models/change_password_model.dart';
import 'package:silab/features/account/domain/usecases/change_password_usecase.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final ChangePasswordUsecase _changePasswordUsecase;

  ChangePasswordBloc(this._changePasswordUsecase)
      : super(const ChangePasswordIdle()) {
    on<SubmitPasswordChange>(_onSubmitPasswordChange);
  }

  Future<void> _onSubmitPasswordChange(
    SubmitPasswordChange event,
    Emitter<ChangePasswordState> emit,
  ) async {
    if (state is ChangePasswordSubmitting ||
        state is ChangePasswordSucceeded) {
      return;
    }

    emit(const ChangePasswordSubmitting());

    final result = await _changePasswordUsecase(event.passwordData);

    result.fold(
      (failure) => emit(ChangePasswordFailed(failure.message)),
      (message) => emit(ChangePasswordSucceeded(message)),
    );
  }
}
