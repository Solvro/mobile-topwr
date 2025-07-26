import "package:home_widget/home_widget.dart";

class WidgetService {
  static const androidPackagePrefix = "com.solvro.topwr";
  static const homeWidgetAndroidName = "$androidPackagePrefix.widgets.HomeWidgetReceiver";

  static Future<void> _saveData<T>(String key, T data) async {
    await HomeWidget.saveWidgetData<T>(key, data);
  }

  static Future<void> updateParkingSlots(String freeSlots) async {
    await _saveData<String>("parking_slots", freeSlots);
    await _updateWidget(qualifiedAndroidName: homeWidgetAndroidName);
  }

  static Future<void> _updateWidget({String? iOSWidgetName, String? qualifiedAndroidName}) async {
    await HomeWidget.updateWidget(
      name: iOSWidgetName,
      iOSName: iOSWidgetName,
      qualifiedAndroidName: qualifiedAndroidName,
    );
  }
}
