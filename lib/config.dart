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