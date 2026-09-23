import 'package:silab/features/realtime/domain/entities/realtime_event_entity.dart';
import 'package:silab/features/realtime/domain/repository/realtime_repository.dart';

class WatchRealtimeEventsUsecase {
  final RealtimeRepository realtimeRepository;

  const WatchRealtimeEventsUsecase(this.realtimeRepository);

  Stream<RealtimeEventEntity> call() => realtimeRepository.watchEvents();
}
