import "package:workmanager/workmanager.dart";

import "background_task_handler.dart";

Future<void> setupParkingWidgetsWorkManager() async {
  await Workmanager().initialize(callbackDispatcher);
  await Workmanager().registerOneOffTask("immediate_task", "widget_wm");
  await Workmanager().registerPeriodicTask("periodic_task", "widget_wm", frequency: const Duration(minutes: 1));
}
