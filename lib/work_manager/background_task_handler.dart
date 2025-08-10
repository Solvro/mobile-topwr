import "dart:async";

import "package:dio/dio.dart";
import "package:workmanager/workmanager.dart";

import "../features/home_screen_app_widgets/widget_service.dart";
import "../features/parkings/parkings_view/api_client/iparking_client.dart";
import "../features/parkings/parkings_view/repository/parkings_repository.dart";
import "../utils/ilist_nonempty.dart";
import "parking_widget_work_manager.dart";

// TODO(mikolaj-jalocha): check if WorkManager can be replaced by AlarmManager
@pragma("vm:entry-point")
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final Dio parkingClient = getIParkingClient();
    if (ParkingWorkManagerTask.immediate.name == task) {
      while (true) {
        await _fetchDataAndUpdateParkingWidget(parkingClient);
        await Future<void>.delayed(const Duration(seconds: 60));
      }
    } else if (ParkingWorkManagerTask.periodic.name == task) {
      await _fetchDataAndUpdateParkingWidget(parkingClient);
      return Future.value(true);
    } else {
      return Future.value(true);
    }
  });
}

Future<void> _fetchDataAndUpdateParkingWidget(Dio parkingClient) async {
  final parkings = await parkingClient.fetchParkings();
  await WidgetService.updateParkingSlots(parkings.toIList());
}
