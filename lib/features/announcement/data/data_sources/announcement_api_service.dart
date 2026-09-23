import 'package:silab/core/network/api_client.dart';
import 'package:silab/features/announcement/domain/entities/announcement_list_response/announcement_list_response_entity.dart';
import 'package:silab/features/announcement/domain/entities/announcement_response/announcement_response_entity.dart';

class AnnouncementApiService {
  final ApiClient _apiClient;

  const AnnouncementApiService(this._apiClient);

  Future<AnnouncementListResponseEntity> getAnnouncementList() async =>
      AnnouncementListResponseEntity.fromJson(
        await _apiClient.get('/announcement'),
      );

  Future<AnnouncementResponseEntity> getAnnouncement({String? id}) async =>
      AnnouncementResponseEntity.fromJson(
        await _apiClient.get('/announcement/$id'),
      );
}
