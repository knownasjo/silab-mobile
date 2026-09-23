part of 'realtime_bloc.dart';

class RealtimeState extends Equatable {
  final RealtimeEventEntity? message;
  final int sequence;

  const RealtimeState({this.message, this.sequence = 0});

  @override
  List<Object?> get props => [message, sequence];
}

final class RealtimeIdle extends RealtimeState {
  const RealtimeIdle();
}

final class RealtimeMessage extends RealtimeState {
  const RealtimeMessage({super.message, super.sequence});
}
