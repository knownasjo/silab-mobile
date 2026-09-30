import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:silab/features/select_subjects/domain/usecases/cancel_activation_usecase.dart';

part 'cancel_activation_event.dart';
part 'cancel_activation_state.dart';

class CancelActivationBloc
    extends Bloc<CancelActivationEvent, CancelActivationState> {
  final CancelActivationUsecase _cancelActivationUsecase;

  CancelActivationBloc(this._cancelActivationUsecase)
      : super(const CancelActivationIdle()) {
    on<CancelActivation>(_onCancelActivation);
  }

  Future<void> _onCancelActivation(
    CancelActivation event,
    Emitter<CancelActivationState> emit,
  ) async {
    if (state is CancelActivationSubmitting) return;

    emit(CancelActivationSubmitting(event.activationId));

    final result = await _cancelActivationUsecase(event.activationId);

    result.fold(
      (failure) => emit(CancelActivationFailed(failure.message)),
      (message) => emit(CancelActivationSucceeded(message)),
    );
  }
}
