import 'package:flutter/foundation.dart';

enum Flavor { prod, dev }

class AppConfig {
  String baseUrl = "";
  String appName = "";
  Flavor flavor = Flavor.dev;

  AppConfig(this.appName, this.baseUrl, this.flavor);

  static AppConfig shared = AppConfig.create();

  factory AppConfig.create({
    String appName = "",
    String baseUrl = "",
    Flavor flavor = Flavor.dev,
  }) {
    return shared = AppConfig(appName, baseUrl, flavor);
  }
}

/// Alamat backend SILAB (silab-backend), sama dengan yang dipakai web admin.
///
/// Atur saat menjalankan atau membangun aplikasi, misalnya untuk HP fisik yang
/// satu Wi-Fi dengan laptop:
///   flutter run --dart-define=API_BASE_URL=http://192.168.1.10:3000
///
/// Tanpa itu, emulator Android memakai 10.0.2.2 (alamat laptop dilihat dari
/// dalam emulator) dan platform lain memakai localhost.
String resolveApiBaseUrl() {
  const fromBuild = String.fromEnvironment('API_BASE_URL');
  if (fromBuild.isNotEmpty) return fromBuild;

  final isAndroid =
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  return isAndroid ? 'http://10.0.2.2:3000' : 'http://localhost:3000';
}
