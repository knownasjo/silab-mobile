import 'package:silab/core/network/api_client.dart';
import 'package:silab/features/authentication/domain/entities/login_response/login_response_entity.dart';
import 'package:silab/features/registration/data/models/register_model.dart';
import 'package:silab/features/registration/domain/entities/registration_entity.dart';

class RegistrationApiService {
  final ApiClient _apiClient;

  const RegistrationApiService(this._apiClient);

  Future<RegistrationEntity> register(RegisterModel registerData) async =>
      RegistrationEntity.fromJson(_data(await _apiClient.post('/auth/register',
          body: registerData.toJson())));

  Future<RegistrationEntity> resendCode(String email) async =>
      RegistrationEntity.fromJson(_data(await _apiClient
          .post('/auth/register/resend', body: {'email': email})));

  Future<LoginResponseEntity> verify(String email, String code) async =>
      LoginResponseEntity.fromJson(await _apiClient.post(
        '/auth/register/verify',
        body: {'email': email, 'code': code},
      ));

  static Map<String, dynamic> _data(Map<String, dynamic> json) {
    final data = json['data'];
    return data is Map<String, dynamic> ? data : const {};
  }
}
