import "dart:io";

import "package:flutter/foundation.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:latlong2/latlong.dart";
import "package:logger/logger.dart";

import "../../../utils/launch_url_util.dart";

class GoogleMapsLinkUtils {
  static Future<void> navigateTo(LatLng latLng, WidgetRef? ref) async {
    final link = _NavigationLaunchLink(latLng);
    final launchedFirst = await ref.launch(link.adaptiveLink);
    if (!launchedFirst) {
      final launchedBackup = await ref.launch(link.backupLink);
      if (!launchedBackup) {
        Logger().e("Could not launch any directions");
      }
    }
  }
}

typedef CoordFunction<T> = num Function(T item);

class _NavigationLaunchLink {
  final LatLng latLng;

  _NavigationLaunchLink(this.latLng);

  String get _locationStr => "${latLng.latitude},${latLng.longitude}";

  String get _androidLink => "https://www.google.com/maps/dir/?api=1&destination=$_locationStr";

  String get _iosLink => "comgooglemaps://?saddr=&daddr=$_locationStr&directionsmode=driving";

  String get adaptiveLink => kIsWeb || Platform.isAndroid ? _androidLink : _iosLink;

  String get backupLink => "https://www.google.com/maps/search/?api=1&query=$_locationStr";
}
