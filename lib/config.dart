import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MyAppConfig {
  static const title = "ToPwr";
}

abstract class AppBarConfig {
  static const logoAssetName = "assets/logo_app_bar.svg";
}

abstract class SplashScreenConfig {
  static const logoAssetName = "assets/splash_screen/splash_logo.png";
  static const additionalWaitDuration = Duration(seconds: 1);
  static const animationDuration = Duration(milliseconds: 800);
  static const androidSplashSizeInDp = 288.0;
  static const androidNativeSplashColor = Color(0xFFEE6644);
}

abstract class ExamSessionCountdownConfig {
  static const defaultDigit = '0';
}

abstract class DepartmentsConfig {
  static const defaultUrl =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1200px-Google_%22G%22_logo.svg.png';
  static const defaultColorFirst = '#BFBEBE';
  static const defaultColorSecond = '#999898';
}

abstract class DateChipConfig {
  static const dateTimeFormat = 'dd.MM.yyyy';
}

abstract class StudyCirclesSectionConfig {
  static const errorMsg = "An error occurred in StudyCircles's scrollable row";
}

abstract class NewsSectionConfig {
  static const errorMsg = "An error occurred in NewsSection's scrollable row";
}

abstract class BigPreviewCardConfig {
  // TODO: Put here proper placeholder reflecting app's logo
  static const placeHolderUrl =
      'https://images.unsplash.com/photo-1533230408708-8f9f91d1235a?q=80&w=1994&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';

  static const double cardHeight = 360;
}

abstract class SearchWidgetConfig {
  static const searchIconName = "assets/search_box/vectorsearch.svg";
  static const height = 36.0;
}

abstract class WideTileCardConfig {
  static const basePadding = 16.0;
  static const minWidthForExtraPadding = 375;
  static const extraPaddingFactor = 0.33;
}

abstract class MapViewBottomSheetConfig {
  static const bottomSheetRadius = Radius.circular(24);
  static const recomendedSheetHeight = 357;
  static const minSheetHeight = 122;
  static const extraSnapPointFraction1 = 0.5;
  static const extraSnapPointFraction2 = 0.8;
  static const lineHandleSectionHeight = 36.0;
}

abstract class MapWidgetConfig {
  static const defaultMarkerZoom = 17.0;
  static const defaultCameraPosition = CameraPosition(
    target: LatLng(51.10738, 17.05964),
    zoom: 16,
  );
  static const mapType = MapType.normal;

  static const mapMarkerAssetName = "assets/map_markers/map_marker.png";
  static const activeMapMarkerAssetName =
      "assets/map_markers/active_map_marker.png";
}
