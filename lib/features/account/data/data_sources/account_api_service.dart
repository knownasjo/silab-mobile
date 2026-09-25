import 'package:silab/core/network/api_client.dart';
import 'package:silab/features/account/data/models/change_password_model.dart';
import 'package:silab/features/authentication/domain/entities/login_response/login_response_entity.dart';

class AccountApiService {
  final ApiClient _apiClient;

  const AccountApiService(this._apiClient);

  Future<String> updateProfile(String fullname) async {
    final json = await _apiClient.put('/auth/me', body: {'fullname': fullname});
    final message = json['message'];

    return message is String ? message : 'Nama berhasil diperbarui';
  }

  Future<LoginResponseEntity> changePassword(
    ChangePasswordModel passwordData,
  ) async =>
      LoginResponseEntity.fromJson(await _apiClient.put(
        '/auth/me/password',
        body: passwordData.toJson(),
      ));
}
