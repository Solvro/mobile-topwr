import "dart:io";

import "package:flutter/material.dart";
import "package:latlong2/latlong.dart";

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
    minSheetHeight: 90,
  );

  static const MapSheetSize parkingsMapSheetSize = (
    recomendedSheetHeight: 357,
    recomendedActiveSheetHeight: 480,
    minSheetHeight: 90,
  );

  static const lineHandleSectionHeight = 36.0;
  static const horizontalPadding = 24.0;

  static const horizontalPanelModeMinWidth = 700;

  static const listAnimationDuration = Duration(milliseconds: 200);
}

abstract class MapWidgetConfig {
  static const defaultMarkerZoom = 17.0;
  static const initialZoom = 15.0;
  static const initialCenter = LatLng(51.10738, 17.05964);

  static const mapMarkerWidth = 22.0;
  static const mapMarkerHeight = 34.0;
  static const activeMapMarkerWidth = 30.4;
  static const activeMapMarkerHeight = 46.4;
}

abstract class OpenStreetMapConfig {
  static const tileUrl = "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png";
  static const attribution = "© OpenStreetMap contributors";
  static const copyright = "https://openstreetmap.org/copyright";
  static final userAgent =
      Platform.isIOS ? "com.solvro.ToPwr" : "com.solvro.topwr";
}

abstract class BuildingSearchConfig {
  static const buildingCodeSeperator = "-";
}
