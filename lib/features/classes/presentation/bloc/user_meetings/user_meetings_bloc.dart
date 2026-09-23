import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:silab/features/classes/domain/entities/meetings/meetings_entity.dart';
import 'package:silab/features/classes/domain/usecases/get_user_meetings_data_usecase.dart';
import 'package:silab/features/classes/domain/usecases/watch_class_events_usecase.dart';

part 'user_meetings_event.dart';
part 'user_meetings_state.dart';

class UserMeetingsBloc extends Bloc<UserMeetingsEvent, UserMeetingsState> {
  final GetUserMeetingsDataUsecase _getUserMeetingsDataUsecase;
  final WatchClassEventsUsecase _watchClassEventsUsecase;

  StreamSubscription<String>? _classEventsSubscription;
  String? _classId;

  UserMeetingsBloc(
    this._getUserMeetingsDataUsecase,
    this._watchClassEventsUsecase,
  ) : super(UserMeetingsInitial()) {
    on<GetUserMeetings>(onGetUserMeetingsData);
    on<RefreshUserMeetings>(
      onRefreshUserMeetings,
      transformer: (events, mapper) => events.asyncExpand(mapper),
    );
    on<WatchUserMeetings>(onWatchUserMeetings);
    on<StopWatchingUserMeetings>(onStopWatchingUserMeetings);
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
    if (event.classId != _classId) return;

    final data = await _getUserMeetingsDataUsecase.classRepository
        .getUserMeetingsData(classId: event.classId);

    if (event.classId != _classId) return;

    data.fold(
      (left) => null,
      (right) => emit(UserMeetingsLoaded(meetingsData: right.data)),
    );
  }

  Future<void> onWatchUserMeetings(
      WatchUserMeetings event, Emitter<UserMeetingsState> emit) async {
    await _classEventsSubscription?.cancel();

    _classEventsSubscription = _watchClassEventsUsecase(params: event.classId)
        .listen((_) => add(RefreshUserMeetings(classId: event.classId)));
  }

  Future<void> onStopWatchingUserMeetings(
      StopWatchingUserMeetings event, Emitter<UserMeetingsState> emit) async {
    await _classEventsSubscription?.cancel();
    _classEventsSubscription = null;
  }

  @override
  Future<void> close() async {
    await _classEventsSubscription?.cancel();
    return super.close();
  }
}
