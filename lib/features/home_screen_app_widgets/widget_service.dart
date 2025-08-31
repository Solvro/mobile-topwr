import "dart:convert";

import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:home_widget/home_widget.dart";
import "../parkings/parkings_view/models/parking.dart";
import "parking_widget_data.dart";

class WidgetService {
  static const androidPackagePrefix = "com.solvro.topwr.widget.parking.receiver";
  static const iOSWidgetAppGroupId = "todo";

  static const _parkingWidgetAndroidMap = <String, String>{
    "GEO-L": "$androidPackagePrefix.GeoParkingWidgetReceiver",
    "D20": "$androidPackagePrefix.D20ParkingWidgetReceiver",
    "WRO": "$androidPackagePrefix.WroParkingWidgetReceiver",
    "C13": "$androidPackagePrefix.C13ParkingWidgetReceiver",
    "EO1": "$androidPackagePrefix.EO1ParkingWidgetReceiver",
  };

  static const _parkingWidgetDataKey = "parking_home_screen_widget_data";

  static Future<void> updateParkingSlots(IList<Parking> parking) async {
    final parkingWidgetDataJson = jsonEncode(parking.map((e) => e.toParkingWidgetData()).toList());
    await HomeWidget.saveWidgetData<String>(_parkingWidgetDataKey, parkingWidgetDataJson);

    for (final p in parking) {
      await _updateWidget(iOSWidgetName: p.symbol, qualifiedAndroidName: _parkingWidgetAndroidMap[p.symbol]);
    }
  }

  static Future<void> _updateWidget({String? iOSWidgetName, String? qualifiedAndroidName}) async {
    await HomeWidget.updateWidget(
      name: iOSWidgetName,
      iOSName: iOSWidgetName,
      qualifiedAndroidName: qualifiedAndroidName,
    );
  }

  static Future<void> initialize() async {
    await HomeWidget.setAppGroupId(iOSWidgetAppGroupId);
  }
}
