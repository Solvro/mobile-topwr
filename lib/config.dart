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

abstract class BottomNavBarConfig {
  static const homeIcon = "assets/bottom_nav_bar/home_icon.svg";
  static const mapIcon = "assets/bottom_nav_bar/map_icon.svg";
  static const schoolIcon = "assets/bottom_nav_bar/school_icon.svg";
  static const scientificCircleIcon = "assets/bottom_nav_bar/scientific_circle_icon.svg";
  static const infoIcon = "assets/bottom_nav_bar/info_icon.svg";
}
