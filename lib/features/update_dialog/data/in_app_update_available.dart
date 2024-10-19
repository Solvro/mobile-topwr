import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:in_app_update/in_app_update.dart";

extension IsInAppUpdateAvailableRef on WidgetRef {
  Future<void> update() async {
    final status = await InAppUpdate.checkForUpdate();
    final isAvailable =
        status.updateAvailability == UpdateAvailability.updateAvailable;
    if (isAvailable) {
      await InAppUpdate.startFlexibleUpdate();
      await InAppUpdate.completeFlexibleUpdate();
    } else {
      throw Exception(status);
    }
  }
}
