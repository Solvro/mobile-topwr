import 'dart:io';

import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../repository/map_buildings_repo.dart';

class GoogleMapsLinkUtils {
  static Future<bool> _launch(String uriStr) async {
    final uri = Uri.parse(uriStr);
    if (await canLaunchUrl(uri)) {
      return await launchUrl(uri);
    }
    return false;
  }

  static Future<void> navigateTo(Building building) async {
    final link = _NavigationLaunchLink(building);
    if (!await _launch(link.adaptiveLink)) {
      if (!await _launch(link.backupLink)) {
        Logger().e('Could not launch any directions');
      }
    }
  }
}

class _NavigationLaunchLink {
  final Building building;

  _NavigationLaunchLink(this.building);

  String get _locationStr => "${building.latitude},${building.longitude}";

  String get _androidLink => "google.navigation:q=$_locationStr&mode=d";
  String get _iosLink =>
      "comgooglemaps://?q=_locationStr&directionsmode=driving";

  String get adaptiveLink => Platform.isAndroid ? _androidLink : _iosLink;

  String get backupLink =>
      "https://www.google.com/maps/search/?api=1&query=$_locationStr";
}
