import "dart:async";
import "dart:io";

import "package:flutter/foundation.dart";
import "package:flutter/services.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../navigation_stack.dart";

extension AndroidPopBugWorkaroundX on WidgetRef {
  static const platform = MethodChannel("topwr.app.android.channel");

  bool get androidSpecialPopTreatment {
    return !kIsWeb && Platform.isAndroid && !watch(isStackPoppableProvider);
  }

  Future<void> handleAndroidSpecialPop() async {
    await platform.invokeMethod<int>("putAppInBackground");
  }
}
