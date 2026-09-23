import 'package:silab/core/network/api_client.dart';
import 'package:silab/features/authentication/data/models/login_model.dart';
import 'package:silab/features/authentication/domain/entities/login_response/login_response_entity.dart';

class AuthenticationApiService {
  final ApiClient _apiClient;

  const AuthenticationApiService(this._apiClient);

  Future<LoginResponseEntity> userLogin(LoginModel loginData) async =>
      LoginResponseEntity.fromJson(
        await _apiClient.post('/auth/login', body: loginData.toJson()),
      );

  /// Peran pemilik token (MAHASISWA, LABORAN, ...). Token login SILAB tidak
  /// memuat peran, jadi harus ditanyakan ke /auth/me.
  Future<String?> getUserRole(String accessToken) async {
    final json = await _apiClient.get('/auth/me', accessToken: accessToken);

    return (json['data'] as Map<String, dynamic>?)?['role'] as String?;
  }
}
