import 'package:silab/core/device/device_id.dart';

class FixedDeviceIdSource extends DeviceIdSource {
  final String? deviceId;

  const FixedDeviceIdSource(this.deviceId);

  @override
  Future<String?> read() async => deviceId;
}
