import 'package:flutter/material.dart';

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

abstract class MapViewConfig {
  static const bottomSheetRadius = Radius.circular(24);
}

abstract class WideTileCardConfig {
  static const minWidthForExtraPadding = 375;
  static const extraPaddingFactor = 0.33;
}
