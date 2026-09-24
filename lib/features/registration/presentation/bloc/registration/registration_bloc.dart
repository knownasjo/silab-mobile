import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:silab/features/registration/data/models/register_model.dart';
import 'package:silab/features/registration/domain/entities/registration_entity.dart';
import 'package:silab/features/registration/domain/usecases/register_usecase.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final RegisterUsecase _registerUsecase;

  RegistrationBloc(this._registerUsecase) : super(const RegistrationInitial()) {
    on<SubmitRegistration>(_onSubmitRegistration);
  }

  Future<void> _onSubmitRegistration(
    SubmitRegistration event,
    Emitter<RegistrationState> emit,
  ) async {
    if (state is RegistrationSubmitting) return;

    emit(const RegistrationSubmitting());

    final result = await _registerUsecase(event.registerData);

    result.fold(
      (failure) => emit(RegistrationFailed(failure.message)),
      (registration) => emit(RegistrationCodeSent(registration)),
    );
  }
}
