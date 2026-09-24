import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:silab/features/registration/domain/entities/registration_entity.dart';
import 'package:silab/features/registration/domain/usecases/resend_registration_code_usecase.dart';
import 'package:silab/features/registration/domain/usecases/verify_registration_usecase.dart';

part 'registration_verification_event.dart';
part 'registration_verification_state.dart';

class RegistrationVerificationBloc
    extends Bloc<RegistrationVerificationEvent, RegistrationVerificationState> {
  final VerifyRegistrationUsecase _verifyRegistrationUsecase;
  final ResendRegistrationCodeUsecase _resendRegistrationCodeUsecase;

  RegistrationVerificationBloc(
    this._verifyRegistrationUsecase,
    this._resendRegistrationCodeUsecase,
  ) : super(const VerificationIdle()) {
    on<SubmitVerificationCode>(_onSubmitVerificationCode);
    on<ResendVerificationCode>(_onResendVerificationCode);
  }

  bool get _isBusy =>
      state is VerificationSubmitting ||
      state is VerificationResending ||
      state is VerificationSucceeded;

  Future<void> _onSubmitVerificationCode(
    SubmitVerificationCode event,
    Emitter<RegistrationVerificationState> emit,
  ) async {
    if (_isBusy) return;

    emit(const VerificationSubmitting());

    final result = await _verifyRegistrationUsecase(event.email, event.code);

    result.fold(
      (failure) => emit(VerificationFailed(failure.message)),
      (message) => emit(VerificationSucceeded(message)),
    );
  }

  Future<void> _onResendVerificationCode(
    ResendVerificationCode event,
    Emitter<RegistrationVerificationState> emit,
  ) async {
    if (_isBusy) return;

    emit(const VerificationResending());

    final result = await _resendRegistrationCodeUsecase(event.email);

    result.fold(
      (failure) => emit(VerificationFailed(failure.message)),
      (registration) => emit(VerificationCodeResent(registration)),
    );
  }
}
