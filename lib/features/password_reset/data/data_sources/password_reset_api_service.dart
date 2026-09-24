import 'package:silab/core/network/api_client.dart';
import 'package:silab/features/password_reset/data/models/reset_password_model.dart';
import 'package:silab/features/password_reset/domain/entities/password_reset_entity.dart';

class PasswordResetApiService {
  final ApiClient _apiClient;

  const PasswordResetApiService(this._apiClient);

  Future<PasswordResetEntity> requestCode(String email) async =>
      PasswordResetEntity.fromJson(_data(await _apiClient
          .post('/auth/password/forgot', body: {'email': email})));

  Future<String> resetPassword(ResetPasswordModel resetData) async {
    final json = await _apiClient.post(
      '/auth/password/reset',
      body: resetData.toJson(),
    );
    final message = json['message'];

    return message is String
        ? message
        : 'Password berhasil diubah, silakan masuk.';
  }

  static Map<String, dynamic> _data(Map<String, dynamic> json) {
    final data = json['data'];
    return data is Map<String, dynamic> ? data : const {};
  }
}
