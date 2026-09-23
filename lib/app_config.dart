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

String resolveApiBaseUrl() {
  const fromBuild = String.fromEnvironment('API_BASE_URL');
  if (fromBuild.isNotEmpty) return fromBuild;

  final isAndroid = !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  return isAndroid ? 'http://10.0.2.2:3000' : 'http://localhost:3000';
}
