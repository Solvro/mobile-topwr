import "package:flutter/services.dart";

class AppHaptics {
  const AppHaptics._();

  static var _isEnabled = true;

  static void setEnabled({required bool isEnabled}) {
    _isEnabled = isEnabled;
  }

  static Future<void> selectionClick() {
    if (!_isEnabled) return Future.value();
    return HapticFeedback.selectionClick();
  }
}
