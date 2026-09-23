import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:silab/features/classes/domain/entities/classmate/classmate_entity.dart';
import 'package:silab/features/classes/domain/usecases/get_classmates_usecase.dart';

part 'classmates_event.dart';
part 'classmates_state.dart';

class ClassmatesBloc extends Bloc<ClassmatesEvent, ClassmatesState> {
  final GetClassmatesUsecase _getClassmatesUsecase;

  ClassmatesBloc(this._getClassmatesUsecase) : super(ClassmatesInitial()) {
    on<GetClassmates>(onGetClassmates);
  }

  void onGetClassmates(
      GetClassmates event, Emitter<ClassmatesState> emit) async {
    emit(ClassmatesLoading());

    final data = await _getClassmatesUsecase(params: event.classId);

    data.fold(
      (left) => emit(ClassmatesFailed(message: left.message)),
      (right) => emit(ClassmatesLoaded(classmates: right.data ?? const [])),
    );
  }
}
