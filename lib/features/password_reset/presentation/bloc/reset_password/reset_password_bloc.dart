import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:silab/features/password_reset/data/models/reset_password_model.dart';
import 'package:silab/features/password_reset/domain/entities/password_reset_entity.dart';
import 'package:silab/features/password_reset/domain/usecases/request_password_reset_code_usecase.dart';
import 'package:silab/features/password_reset/domain/usecases/reset_password_usecase.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final ResetPasswordUsecase _resetPasswordUsecase;
  final RequestPasswordResetCodeUsecase _requestPasswordResetCodeUsecase;

  ResetPasswordBloc(
    this._resetPasswordUsecase,
    this._requestPasswordResetCodeUsecase,
  ) : super(const ResetPasswordIdle()) {
    on<SubmitNewPassword>(_onSubmitNewPassword);
    on<ResendResetCode>(_onResendResetCode);
  }

  bool get _isBusy =>
      state is ResetPasswordSubmitting ||
      state is ResetPasswordResending ||
      state is ResetPasswordSucceeded;

  Future<void> _onSubmitNewPassword(
    SubmitNewPassword event,
    Emitter<ResetPasswordState> emit,
  ) async {
    if (_isBusy) return;

    emit(const ResetPasswordSubmitting());

    final result = await _resetPasswordUsecase(event.resetData);

    result.fold(
      (failure) => emit(ResetPasswordFailed(failure.message)),
      (message) => emit(ResetPasswordSucceeded(message)),
    );
  }

  Future<void> _onResendResetCode(
    ResendResetCode event,
    Emitter<ResetPasswordState> emit,
  ) async {
    if (_isBusy) return;

    emit(const ResetPasswordResending());

    final result = await _requestPasswordResetCodeUsecase(event.email);

    result.fold(
      (failure) => emit(ResetPasswordFailed(failure.message)),
      (reset) => emit(ResetPasswordCodeResent(reset)),
    );
  }
}
