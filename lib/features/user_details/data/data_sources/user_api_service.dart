import 'package:silab/core/network/api_client.dart';
import 'package:silab/features/user_details/domain/entities/user_detail_response/user_detail_response_entity.dart';

class UserApiService {
  final ApiClient _apiClient;

  const UserApiService(this._apiClient);

  Future<UserDetailResponseEntity> getUserDetails() async =>
      UserDetailResponseEntity.fromJson(await _apiClient.get('/auth/me'));
}
