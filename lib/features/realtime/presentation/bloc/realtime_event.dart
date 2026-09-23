part of 'realtime_bloc.dart';

class RealtimeEvent extends Equatable {
  const RealtimeEvent();

  @override
  List<Object?> get props => [];
}

final class StartRealtime extends RealtimeEvent {
  const StartRealtime();
}

final class StopRealtime extends RealtimeEvent {
  const StopRealtime();
}

final class RealtimeMessageReceived extends RealtimeEvent {
  final RealtimeEventEntity message;

  const RealtimeMessageReceived(this.message);

  @override
  List<Object?> get props => [message];
}
