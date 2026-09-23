import 'package:silab/features/realtime/domain/entities/realtime_event_entity.dart';

abstract class RealtimeRepository {
  Stream<RealtimeEventEntity> watchEvents();
}
