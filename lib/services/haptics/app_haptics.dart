import "dart:async";

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

  static Future<void> lightImpact() {
    if (!_isEnabled) return Future.value();
    return HapticFeedback.lightImpact();
  }

  static Future<void> mediumImpact() {
    if (!_isEnabled) return Future.value();
    return HapticFeedback.mediumImpact();
  }

  static Future<void> heavyImpact() {
    if (!_isEnabled) return Future.value();
    return HapticFeedback.heavyImpact();
  }

  static void Function()? wrapperSelection(void Function()? callback) => _wrapper(callback, selectionClick);

  static void Function()? wrapperLight(void Function()? callback) => _wrapper(callback, lightImpact);

  static void Function()? wrapperMedium(void Function()? callback) => _wrapper(callback, mediumImpact);

  static void Function()? wrapperHeavy(void Function()? callback) => _wrapper(callback, heavyImpact);

  static void Function()? _wrapper(void Function()? callback, Future<void> Function() haptic) {
    if (callback == null) return null;

    return () {
      unawaited(haptic());
      callback();
    };
  }
}
