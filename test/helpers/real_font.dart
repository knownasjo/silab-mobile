import 'dart:io';

import 'package:flutter/services.dart';

const realFontFamily = 'RealFont';

Future<void> loadRealFont() async {
  final root = Platform.environment['FLUTTER_ROOT'] ??
      File(Platform.resolvedExecutable)
          .parent
          .parent
          .parent
          .parent
          .parent
          .parent
          .path;
  final loader = FontLoader(realFontFamily);

  for (final weight in ['Light', 'Regular', 'Medium', 'Bold']) {
    final file =
        File('$root/bin/cache/artifacts/material_fonts/Roboto-$weight.ttf');
    if (!file.existsSync()) {
      throw StateError('Font Roboto tidak ditemukan di ${file.path}');
    }
    loader.addFont(Future.value(ByteData.sublistView(file.readAsBytesSync())));
  }

  await loader.load();
}
