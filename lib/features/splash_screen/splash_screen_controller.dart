import "dart:io";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_native_splash/flutter_native_splash.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../api_base/hive_init.dart";
import "../../config/ui_config.dart";
import "../../firebase_init.dart";
import "../home_view/widgets/logo_app_bar.dart";

part "splash_screen_controller.g.dart";

@riverpod
class SplashScreenController extends _$SplashScreenController {
  Future<void> _initializationLogic() async {
    /*
      Insert here any initialization async logic or operations 
      to be performed, when SplashScreen is showed.
    */
    WidgetsFlutterBinding.ensureInitialized();
    await firebaseInit();
    await initHiveForGraphqlCache();
    await AppBarLogo.precacheImageIfAbsent();
  }

  @override
  Future<void> build() async {
    await _initializationLogic();
    await Future.delayed(SplashScreenConfig.additionalWaitDuration);
    hideNativeSplashScreen();
  }

  /// Whether preserves native splash or show flutter one
  static bool get _preserveNativeSplash => kIsWeb || !Platform.isAndroid;

  /// Preserves native splash screen, except of Android, where FlutterSplashScreen is showed as soon as possible
  static void preserveNativeSplashScreen() {
    if (_preserveNativeSplash) {
      final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    }
  }

  /// Hides native splash screen (no effect on Android)
  static void hideNativeSplashScreen() {
    if (_preserveNativeSplash) {
      FlutterNativeSplash.remove();
    }
  }
}
