import "package:workmanager/workmanager.dart";

import "background_task_handler.dart";

enum ParkingWorkManagerTask {
  immediate("immediate"),
  periodic("periodic");

  final String taskName;

  static ParkingWorkManagerTask? fromUniqueTaskName(String name) {
    for (final task in ParkingWorkManagerTask.values) {
      if (task.taskName == name) return task;
    }
    return null;
  }

  const ParkingWorkManagerTask(this.taskName);
}

Future<void> setupParkingWidgetsWorkManager() async {
  await Workmanager().initialize(callbackDispatcher);
  await Workmanager().registerOneOffTask(
    ParkingWorkManagerTask.immediate.taskName,
    ParkingWorkManagerTask.immediate.taskName,
    existingWorkPolicy: ExistingWorkPolicy.keep,
  );
  await Workmanager().registerPeriodicTask(
    ParkingWorkManagerTask.periodic.taskName,
    ParkingWorkManagerTask.periodic.taskName,
    frequency: const Duration(minutes: 1),
    existingWorkPolicy: ExistingWorkPolicy.keep,
  );
}
