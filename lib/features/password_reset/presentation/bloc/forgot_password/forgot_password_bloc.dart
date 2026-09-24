import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:silab/core/failures/failures.dart';
import 'package:silab/features/password_reset/domain/entities/password_reset_entity.dart';
import 'package:silab/features/password_reset/domain/usecases/request_password_reset_code_usecase.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final RequestPasswordResetCodeUsecase _requestPasswordResetCodeUsecase;

  ForgotPasswordBloc(this._requestPasswordResetCodeUsecase)
      : super(const ForgotPasswordInitial()) {
    on<SubmitForgotPassword>(_onSubmitForgotPassword);
  }

  Future<void> _onSubmitForgotPassword(
    SubmitForgotPassword event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    if (state is ForgotPasswordSubmitting) return;

    emit(const ForgotPasswordSubmitting());

    final result = await _requestPasswordResetCodeUsecase(event.email);

    result.fold(
      (failure) => emit(
        failure is UnverifiedAccountFailures
            ? ForgotPasswordUnverified(
                email: failure.email,
                message: failure.message,
              )
            : ForgotPasswordFailed(failure.message),
      ),
      (reset) => emit(ForgotPasswordCodeSent(reset)),
    );
  }
}
