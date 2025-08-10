import "dart:io";

import "package:workmanager/workmanager.dart";

import "background_task_handler.dart";

enum ParkingWorkManagerTask { immediate, periodic }

Future<void> setupParkingWidgetsWorkManager() async {
  await Workmanager().initialize(callbackDispatcher);

  // On Android minimum interval is 15 minutes (as of 10/08/2025).
  // Thus we're launching here immediate worker that's enclosed in infinite loop with 60 sec interval
  // 2nd one - periodic - is for safety. There's a chance that OS will kill immediate worker (it's not supposed to be enclosed in infinite loop), good to have alternative

  if (Platform.isAndroid) {
    await Workmanager().registerOneOffTask(
      ParkingWorkManagerTask.immediate.name,
      ParkingWorkManagerTask.immediate.name,
      existingWorkPolicy: ExistingWorkPolicy.keep,
    );
  }
  await Workmanager().registerPeriodicTask(
    ParkingWorkManagerTask.periodic.name,
    ParkingWorkManagerTask.periodic.name,
    frequency: Duration(minutes: Platform.isAndroid ? 15 : 1),
    existingWorkPolicy: ExistingWorkPolicy.keep,
  );
}
