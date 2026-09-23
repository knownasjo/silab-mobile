import 'package:silab/core/network/api_client.dart';
import 'package:silab/features/realtime/domain/entities/realtime_event_entity.dart';

class RealtimeApiService {
  final ApiClient _apiClient;

  const RealtimeApiService(this._apiClient);

  Stream<RealtimeEventEntity> watchEvents() => _apiClient
      .listen('/events')
      .map((event) => RealtimeEventEntity.fromJson(event.type, event.data));
}
