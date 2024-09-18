import "package:flutter/foundation.dart";
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
    final configuration = context.mapMarkerConfiguration;
    final activeMarkerConfig = context.activeMapMarkerConfiguration;
    buildingMapMarker = await BitmapDescriptor.asset(
      configuration,
      Assets.png.mapMarkers.mapMarker.path,
    );
    activeBuildingMapMarker = await BitmapDescriptor.asset(
      activeMarkerConfig,
      Assets.png.mapMarkers.activeMapMarker.path,
    );
    parkingMapMarker = await BitmapDescriptor.asset(
      configuration,
      Assets.png.mapMarkers.parkingMapMarker.path,
    );
    activeParkingMapMarker = await BitmapDescriptor.asset(
      activeMarkerConfig,
      Assets.png.mapMarkers.activeParkingMapMarker.path,
    );
  }
}

extension _ImageConfigurationX on BuildContext {
  double get pixelRatio => kIsWeb ? 1.0 : MediaQuery.devicePixelRatioOf(this);

  ImageConfiguration get mapMarkerConfiguration => ImageConfiguration(
        devicePixelRatio: pixelRatio,
        size: const Size(
          MapWidgetConfig.mapMarkerWidth,
          MapWidgetConfig.mapMarkerHeight,
        ),
      );
  ImageConfiguration get activeMapMarkerConfiguration => ImageConfiguration(
        devicePixelRatio: pixelRatio,
        size: const Size(
          MapWidgetConfig.activeMapMarkerWidth,
          MapWidgetConfig.activeMapMarkerHeight,
        ),
      );
}
