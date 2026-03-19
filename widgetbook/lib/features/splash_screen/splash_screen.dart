import "package:flutter/widgets.dart";
import "package:topwr/features/splash_screen/splash_screen.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: SplashScreen)
Widget useCaseSplashScreen(BuildContext context) {
  return const SplashScreen(child: SizedBox(width: 100, height: 100));
}
