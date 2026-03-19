import "package:flutter/widgets.dart";
import "package:topwr/widgets/tile_splash.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: TileSplash)
Widget useCaseTileSplash(BuildContext context) {
  return const TileSplash();
}
