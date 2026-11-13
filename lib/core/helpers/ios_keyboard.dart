import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

bool get _isIos => !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;

TapRegionCallback? get hideIosKeyboardOnTapOutside =>
    _isIos ? (_) => FocusManager.instance.primaryFocus?.unfocus() : null;

void hideIosKeyboard() {
  if (!_isIos) return;
  FocusManager.instance.primaryFocus?.unfocus();
  SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
}
