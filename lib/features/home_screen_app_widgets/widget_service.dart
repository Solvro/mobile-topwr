import "dart:convert";

import "package:home_widget/home_widget.dart";
import "../parkings/parkings_view/models/parking.dart";
import "parking_widget_data.dart";

class WidgetService {
  static const androidPackagePrefix = "com.solvro.topwr";

  static const _parkingWidgetAndroidNameGEO = "$androidPackagePrefix.widgets.GeoParkingWidgetReceiver";
  static const _parkingWidgetAndroidNameD20 = "$androidPackagePrefix.widgets.D20ParkingWidgetReceiver";
  static const _parkingWidgetAndroidNameWRO = "$androidPackagePrefix.widgets.WroParkingWidgetReceiver";
  static const _parkingWidgetAndroidNameC13 = "$androidPackagePrefix.widgets.C13ParkingWidgetReceiver";
  static const _parkingWidgetAndroidNameEO1 = "$androidPackagePrefix.widgets.EO1ParkingWidgetReceiver";

  static Future<void> updateParkingSlots(Parking parking) async {
    final parkingWidgetData = parking.toParkingWidgetData();
    await HomeWidget.saveWidgetData<String>(parkingWidgetData.symbol, jsonEncode(parkingWidgetData));
    await _updateWidget(qualifiedAndroidName: _getParkingWidgetAndroidName(parking.symbol));
  }

  static String _getParkingWidgetAndroidName(String key) {
    switch (key.toLowerCase()) {
      case "geo-l":
        return _parkingWidgetAndroidNameGEO;
      case "d20":
        return _parkingWidgetAndroidNameD20;
      case "wro":
        return _parkingWidgetAndroidNameWRO;
      case "c13":
        return _parkingWidgetAndroidNameC13;
      case "e01":
        return _parkingWidgetAndroidNameEO1;
      default:
        throw ArgumentError("Unknown parking widget key: $key");
    }
  }

  static Future<void> _updateWidget({String? iOSWidgetName, String? qualifiedAndroidName}) async {
    await HomeWidget.updateWidget(
      name: iOSWidgetName,
      iOSName: iOSWidgetName,
      qualifiedAndroidName: qualifiedAndroidName,
    );
  }
}
