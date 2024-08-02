import "dart:ui" as ui;

import "package:flutter/foundation.dart";
import "package:flutter/services.dart";
import "package:flutter/widgets.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";

import "../../../config/map_view_config.dart";
import "../../../gen/assets.gen.dart";

class MapMarkerUtils {
  static late final BitmapDescriptor buildingMapMarker;
  static late final BitmapDescriptor activeBuildingMapMarker;
  static late final BitmapDescriptor parkingMapMarker;
  static late final BitmapDescriptor activeParkingMapMarker;

  static Future<void> loadMapMarkerAssets(BuildContext context) async {
    final pixelRatio =
        kIsWeb ? 1 : MediaQuery.devicePixelRatioOf(context).toInt();

    buildingMapMarker = await _AssetScaledLoader.loadScaledBitmapDescriptor(
      Assets.mapMarkers.mapMarker.path,
      width: MapWidgetConfig.mapMarkerOriginWidth * pixelRatio,
    );

    activeBuildingMapMarker =
        await _AssetScaledLoader.loadScaledBitmapDescriptor(
      Assets.mapMarkers.activeMapMarker.path,
      width: MapWidgetConfig.activeMapMarkerOriginWidth * pixelRatio,
    );
    parkingMapMarker = await _AssetScaledLoader.loadScaledBitmapDescriptor(
      Assets.mapMarkers.parkingMapMarker.path,
      width: MapWidgetConfig.mapMarkerOriginWidth * pixelRatio,
    );
    activeParkingMapMarker =
        await _AssetScaledLoader.loadScaledBitmapDescriptor(
      Assets.mapMarkers.activeParkingMapMarker.path,
      width: MapWidgetConfig.activeMapMarkerOriginWidth * pixelRatio,
    );
  }
}

class _AssetScaledLoader {
  static Future<BitmapDescriptor> loadScaledBitmapDescriptor(
    String assetName, {
    required int width,
  }) async {
    try {
      final data = await rootBundle.load(assetName);
      final codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(),
        targetWidth: width,
      );
      final fi = await codec.getNextFrame();
      final decode = await fi.image.toByteData(format: ui.ImageByteFormat.png);
      return BitmapDescriptor.bytes(decode!.buffer.asUint8List());
    } on Exception {
      return BitmapDescriptor.defaultMarker; // fallback
    }
  }
}
