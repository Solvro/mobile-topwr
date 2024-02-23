import 'dart:io';

import 'package:logger/logger.dart';

import '../../../repositories/buildings_repository/map_buildings_repo.dart';
import '../../../utils/launch_url_util.dart';

class GoogleMapsLinkUtils {
  static Future<void> navigateTo(Building building) async {
    final link = _NavigationLaunchLink(building);
    final launchedFirst = await LaunchUrlUtil.launch(link.adaptiveLink);
    if (!launchedFirst) {
      final launchedBackup = await LaunchUrlUtil.launch(link.backupLink);
      if (!launchedBackup) {
        Logger().e('Could not launch any directions');
      }
    }
  }
}

class _NavigationLaunchLink {
  final Building building;

  _NavigationLaunchLink(this.building);

  String get _locationStr => "${building.latitude},${building.longitude}";

  String get _androidLink => "google.navigation:q=$_locationStr";
  String get _iosLink =>
      "comgooglemaps://?saddr=&daddr=$_locationStr&directionsmode=driving";

  String get adaptiveLink => Platform.isAndroid ? _androidLink : _iosLink;

  String get backupLink =>
      "https://www.google.com/maps/search/?api=1&query=$_locationStr";
}
