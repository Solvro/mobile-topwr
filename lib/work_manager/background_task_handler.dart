import "dart:async";
import "dart:math";

import "package:dio/dio.dart";
import "package:workmanager/workmanager.dart";

import "../config/env.dart";
import "../features/home_screen_app_widgets/widget_service.dart";
import "../features/parkings/parkings_view/api_client/iparking_client.dart";
import "../features/parkings/parkings_view/models/parking.dart";

@pragma("vm:entry-point")
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final parkings = await _fetchParkings();
    for (final parking in parkings) {
      await WidgetService.updateParkingSlots(parking.copyWith(numberOfPlaces: Random().nextInt(1300).toString()));
    }
    return Future.value(true);
  });
}

// TODO(mikolaj-jalocha): find better way for doing this
Future<List<Parking>> _fetchParkings() async {
  final Dio dio = Dio(BaseOptions(baseUrl: ParkingsConfig.soapFullUrl, headers: ParkingsConfig.headers));
  final url = Env.parkingApiUrl;
  final response = await dio.get<Map<String, dynamic>>(url);
  final places = response.data?["places"] as List<dynamic>;
  return places.whereType<Map<String, dynamic>>().map(Parking.fromJson).toList();
}
