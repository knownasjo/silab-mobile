import 'package:flutter_udid/flutter_udid.dart';

abstract class DeviceIdSource {
  const DeviceIdSource();

  Future<String?> read();
}

class UdidDeviceIdSource extends DeviceIdSource {
  const UdidDeviceIdSource();

  static String? _deviceId;

  @override
  Future<String?> read() async {
    try {
      return _deviceId ??= await FlutterUdid.consistentUdid;
    } catch (_) {
      return null;
    }
  }
}
