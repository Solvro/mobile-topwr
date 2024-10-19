import "dart:async";
import "dart:io";

import "package:flutter/foundation.dart";
import "package:flutter/services.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../navigation_controller.dart";

extension AndroidPopBugWorkaroundX on WidgetRef {
  static const platform = MethodChannel("topwr.app.android.channel");

  bool get androidSpecialPopTreatment {
    return !kIsWeb &&
        Platform.isAndroid &&
        !read(navigationControllerProvider).isStackPoppable;
  }

  Future<void> handleAndroidSpecialPop(_) async {
    await platform.invokeMethod<int>("putAppInBackground");
  }
}
