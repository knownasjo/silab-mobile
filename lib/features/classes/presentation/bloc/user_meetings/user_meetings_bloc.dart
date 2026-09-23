import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:silab/core/helpers/event_transformers.dart';
import 'package:silab/features/classes/domain/entities/meetings/meetings_entity.dart';
import 'package:silab/features/classes/domain/usecases/get_user_meetings_data_usecase.dart';

part 'user_meetings_event.dart';
part 'user_meetings_state.dart';

class UserMeetingsBloc extends Bloc<UserMeetingsEvent, UserMeetingsState> {
  final GetUserMeetingsDataUsecase _getUserMeetingsDataUsecase;

  String? _classId;

  UserMeetingsBloc(this._getUserMeetingsDataUsecase)
      : super(UserMeetingsInitial()) {
    on<GetUserMeetings>(onGetUserMeetingsData);
    on<RefreshUserMeetings>(onRefreshUserMeetings, transformer: sequential());
  }

  void onGetUserMeetingsData(
      UserMeetingsEvent event, Emitter<UserMeetingsState> emit) async {
    _classId = event.classId;
    emit(UserMeetingsLoading());

    final data = await _getUserMeetingsDataUsecase.classRepository
        .getUserMeetingsData(classId: event.classId);

    data.fold(
      (left) => emit(UserMeetingsFailed(message: left.message)),
      (right) => emit(UserMeetingsLoaded(meetingsData: right.data)),
    );
  }

  Future<void> onRefreshUserMeetings(
      RefreshUserMeetings event, Emitter<UserMeetingsState> emit) async {
    final classId = event.classId ?? _classId;
    if (classId == null || classId != _classId) return;

    final data = await _getUserMeetingsDataUsecase.classRepository
        .getUserMeetingsData(classId: classId);

    if (classId != _classId) return;

    data.fold(
      (left) => null,
      (right) => emit(UserMeetingsLoaded(meetingsData: right.data)),
    );
  }
}
