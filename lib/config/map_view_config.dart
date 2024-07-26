import "package:flutter/material.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";

typedef MapSheetSize = ({
  double recomendedSheetHeight,
  double recomendedActiveSheetHeight,
  double minSheetHeight,
});

abstract class MapViewBottomSheetConfig {
  static const bottomSheetRadius = Radius.circular(24);

  static const MapSheetSize buildingsMapSheetSize = (
    recomendedSheetHeight: 357,
    recomendedActiveSheetHeight: 357,
    minSheetHeight: 150,
  );

  static const MapSheetSize parkingsMapSheetSize = (
    recomendedSheetHeight: 357,
    recomendedActiveSheetHeight: 480,
    minSheetHeight: 150,
  );

  static const lineHandleSectionHeight = 36.0;
  static const horizontalPadding = 24.0;

  static const horizontalPanelModeMinWidth = 700;
}

abstract class MapWidgetConfig {
  static const defaultMarkerZoom = 17.0;
  static const defaultCameraPosition = CameraPosition(
    target: LatLng(51.10738, 17.05964),
    zoom: 16,
  );
  static const mapType = MapType.normal;

  static const mapMarkerOriginWidth = 28;
  static const activeMapMarkerOriginWidth = 40;
}

abstract class BuildingSearchConfig {
  static const buildingCodeSeperator = "-";
}
