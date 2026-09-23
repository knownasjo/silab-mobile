import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:silab/core/helpers/event_transformers.dart';
import 'package:silab/features/classes/domain/entities/classmate/classmate_entity.dart';
import 'package:silab/features/classes/domain/usecases/get_classmates_usecase.dart';

part 'classmates_event.dart';
part 'classmates_state.dart';

class ClassmatesBloc extends Bloc<ClassmatesEvent, ClassmatesState> {
  final GetClassmatesUsecase _getClassmatesUsecase;

  String? _classId;

  ClassmatesBloc(this._getClassmatesUsecase) : super(ClassmatesInitial()) {
    on<GetClassmates>(onGetClassmates);
    on<RefreshClassmates>(onRefreshClassmates, transformer: sequential());
  }

  void onGetClassmates(
      GetClassmates event, Emitter<ClassmatesState> emit) async {
    _classId = event.classId;
    emit(ClassmatesLoading());

    final data = await _getClassmatesUsecase(params: event.classId);

    data.fold(
      (left) => emit(ClassmatesFailed(message: left.message)),
      (right) => emit(ClassmatesLoaded(classmates: right.data ?? const [])),
    );
  }

  Future<void> onRefreshClassmates(
      RefreshClassmates event, Emitter<ClassmatesState> emit) async {
    final classId = event.classId ?? _classId;
    if (classId == null || classId != _classId) return;

    final data = await _getClassmatesUsecase(params: classId);

    if (classId != _classId) return;

    data.fold(
      (left) => null,
      (right) => emit(ClassmatesLoaded(classmates: right.data ?? const [])),
    );
  }
}
