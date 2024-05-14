import 'dart:io';

import 'package:logger/logger.dart';

import '../../../utils/launch_url_util.dart';

class GoogleMapsLinkUtils {
  static Future<void> navigateTo<T>(
    T item, {
    required CoordFunction<T> lat,
    required CoordFunction<T> long,
  }) async {
    final link = _NavigationLaunchLink(item, lat, long);
    final launchedFirst = await LaunchUrlUtil.launch(link.adaptiveLink);
    if (!launchedFirst) {
      final launchedBackup = await LaunchUrlUtil.launch(link.backupLink);
      if (!launchedBackup) {
        Logger().e('Could not launch any directions');
      }
    }
  }
}

typedef CoordFunction<T> = num Function(T item);

class _NavigationLaunchLink<T> {
  final T item;
  final CoordFunction<T> latitude;
  final CoordFunction<T> longitude;

  _NavigationLaunchLink(this.item, this.latitude, this.longitude);

  String get _locationStr => "${latitude(item)},${longitude(item)}";

  String get _androidLink => "google.navigation:q=$_locationStr";
  String get _iosLink =>
      "comgooglemaps://?saddr=&daddr=$_locationStr&directionsmode=driving";

  String get adaptiveLink => Platform.isAndroid ? _androidLink : _iosLink;

  String get backupLink =>
      "https://www.google.com/maps/search/?api=1&query=$_locationStr";
}
