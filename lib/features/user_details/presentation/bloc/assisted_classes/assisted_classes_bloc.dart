import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:silab/core/helpers/event_transformers.dart';
import 'package:silab/features/user_details/domain/entities/assisted_class/assisted_class_entity.dart';
import 'package:silab/features/user_details/domain/usecases/get_assisted_classes_usecase.dart';

part 'assisted_classes_event.dart';
part 'assisted_classes_state.dart';

class AssistedClassesBloc
    extends Bloc<AssistedClassesEvent, AssistedClassesState> {
  final GetAssistedClassesUsecase _getAssistedClassesUsecase;

  AssistedClassesBloc(this._getAssistedClassesUsecase)
      : super(const AssistedClassesInitial()) {
    on<GetAssistedClasses>(_onGetAssistedClasses);
    on<RefreshAssistedClasses>(
      _onRefreshAssistedClasses,
      transformer: sequential(),
    );
  }

  Future<void> _onGetAssistedClasses(
    GetAssistedClasses event,
    Emitter<AssistedClassesState> emit,
  ) async {
    if (state is! AssistedClassesLoaded) emit(const AssistedClassesLoading());

    final result = await _getAssistedClassesUsecase();

    result.fold(
      (failure) => emit(AssistedClassesFailed(failure.message)),
      (classes) => emit(AssistedClassesLoaded(classes)),
    );
  }

  Future<void> _onRefreshAssistedClasses(
    RefreshAssistedClasses event,
    Emitter<AssistedClassesState> emit,
  ) async {
    if (state is AssistedClassesInitial) return;

    final result = await _getAssistedClassesUsecase();

    if (result.isRight) emit(AssistedClassesLoaded(result.right));
  }
}
