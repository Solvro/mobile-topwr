import "dart:io";

import "package:workmanager/workmanager.dart";

import "../features/home_screen_app_widgets/widget_service.dart";
import "background_task_handler.dart";

enum ParkingWorkManagerTask { periodic }

Future<void> setupParkingWidgetsWorkManager() async {
  if (Platform.isIOS) {
    await WidgetService.initialize();
  }
  await Workmanager().initialize(callbackDispatcher);

  await Workmanager().registerPeriodicTask(
    ParkingWorkManagerTask.periodic.name,
    ParkingWorkManagerTask.periodic.name,
    frequency: Duration(minutes: Platform.isAndroid ? 15 : 1),
  );
}
