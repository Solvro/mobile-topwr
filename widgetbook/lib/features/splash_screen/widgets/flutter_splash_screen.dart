import "package:flutter/widgets.dart";
import "package:topwr/features/splash_screen/widgets/flutter_splash_screen.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: FlutterSplashScreen)
Widget useCaseFlutterSplashScreen(BuildContext context) {
  return const FlutterSplashScreen();
}
