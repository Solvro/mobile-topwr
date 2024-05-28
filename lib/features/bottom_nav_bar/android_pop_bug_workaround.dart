import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'nested_navigator.dart';

extension AndroidPopBugWorkaround on NestedNavigator {
  static const platform = MethodChannel('topwr.app.android.channel');

  bool get androidSpecialPopTreatment =>
      !kIsWeb &&
      Platform.isAndroid &&
      navigatorKey.currentState?.canPop() == false;

  void handleAndroidSpecialPop() {
    platform.invokeMethod<int>('putAppInBackground');
  }
}
