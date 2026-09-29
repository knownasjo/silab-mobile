import 'package:silab/core/device/device_id.dart';
import 'package:silab/core/network/api_client.dart';
import 'package:silab/features/authentication/data/models/login_model.dart';
import 'package:silab/features/authentication/domain/entities/login_response/login_response_entity.dart';

class AuthenticationApiService {
  final ApiClient _apiClient;
  final DeviceIdSource _deviceId;

  const AuthenticationApiService(
    this._apiClient, [
    this._deviceId = const UdidDeviceIdSource(),
  ]);

  Stream<void> get sessionEnded => _apiClient.sessionEnded;

  Future<LoginResponseEntity> userLogin(LoginModel loginData) async {
    final deviceId = await _deviceId.read();

    return LoginResponseEntity.fromJson(
      await _apiClient.post('/auth/login', body: {
        ...loginData.toJson(),
        if (deviceId != null) 'device_id': deviceId,
      }),
    );
  }

  Future<String?> getUserRole(String accessToken) async {
    final json = await _apiClient.get('/auth/me', accessToken: accessToken);

    return (json['data'] as Map<String, dynamic>?)?['role'] as String?;
  }
}
