import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:silab/features/realtime/domain/entities/realtime_event_entity.dart';
import 'package:silab/features/realtime/domain/usecases/watch_realtime_events_usecase.dart';

part 'realtime_event.dart';
part 'realtime_state.dart';

class RealtimeBloc extends Bloc<RealtimeEvent, RealtimeState> {
  final WatchRealtimeEventsUsecase _watchRealtimeEventsUsecase;

  StreamSubscription<RealtimeEventEntity>? _subscription;
  bool _hasConnected = false;
  int _sequence = 0;

  RealtimeBloc(this._watchRealtimeEventsUsecase) : super(const RealtimeIdle()) {
    on<StartRealtime>(onStartRealtime);
    on<StopRealtime>(onStopRealtime);
    on<RealtimeMessageReceived>(onRealtimeMessageReceived);
  }

  void onStartRealtime(StartRealtime event, Emitter<RealtimeState> emit) {
    _subscription?.cancel();
    _subscription = _watchRealtimeEventsUsecase()
        .listen((message) => add(RealtimeMessageReceived(message)));
  }

  void onStopRealtime(StopRealtime event, Emitter<RealtimeState> emit) {
    _subscription?.cancel();
    _subscription = null;
    _hasConnected = false;
    emit(const RealtimeIdle());
  }

  void onRealtimeMessageReceived(
      RealtimeMessageReceived event, Emitter<RealtimeState> emit) {
    if (_subscription == null) return;

    if (event.message.type == 'ready' && !_hasConnected) {
      _hasConnected = true;
      return;
    }

    emit(RealtimeMessage(message: event.message, sequence: ++_sequence));
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
