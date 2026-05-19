import "package:flutter/services.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:in_app_update/in_app_update.dart";

import "../utils/in_app_update_errors.dart";

extension IsInAppUpdateAvailableRef on WidgetRef {
  Future<void> update() async {
    try {
      final status = await InAppUpdate.checkForUpdate();
      final isAvailable = status.updateAvailability == UpdateAvailability.updateAvailable;
      if (!isAvailable) {
        return;
      }

      await InAppUpdate.startFlexibleUpdate();
      await InAppUpdate.completeFlexibleUpdate();
    } on PlatformException catch (exception) {
      if (isIgnorableInAppUpdateError(exception)) {
        return;
      }
      rethrow;
    }
  }
}
