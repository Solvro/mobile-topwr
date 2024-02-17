import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../config.dart';

class MapMarkerUtils {
  static late final BitmapDescriptor mapMarker;
  static late final BitmapDescriptor activeMapMarker;

  static Future<void> loadMapMarkerAssets(BuildContext context) async {
    final pixelRatio = MediaQuery.devicePixelRatioOf(context).toInt();

    mapMarker = await _AssetScaledLoader.loadScaledBitmapDescriptor(
      MapWidgetConfig.mapMarkerAssetName,
      width: MapWidgetConfig.mapMarkerOriginWidth * pixelRatio,
    );

    activeMapMarker = await _AssetScaledLoader.loadScaledBitmapDescriptor(
      MapWidgetConfig.activeMapMarkerAssetName,
      width: MapWidgetConfig.activeMapMarkerOriginWidth * pixelRatio,
    );
  }
}

class _AssetScaledLoader {
  static Future<BitmapDescriptor> loadScaledBitmapDescriptor(
    String assetName, {
    required int width,
  }) async {
    final data = await rootBundle.load(assetName);
    final codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );
    final fi = await codec.getNextFrame();
    final decode = await fi.image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(decode!.buffer.asUint8List());
  }
}
