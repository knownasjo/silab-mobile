import 'package:silab/features/realtime/data/data_sources/realtime_api_service.dart';
import 'package:silab/features/realtime/domain/entities/realtime_event_entity.dart';
import 'package:silab/features/realtime/domain/repository/realtime_repository.dart';

class RealtimeRepositoryImpl implements RealtimeRepository {
  final RealtimeApiService _realtimeApiService;

  const RealtimeRepositoryImpl(this._realtimeApiService);

  @override
  Stream<RealtimeEventEntity> watchEvents() =>
      _realtimeApiService.watchEvents();
}
