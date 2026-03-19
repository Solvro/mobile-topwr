import "package:flutter/widgets.dart";
import "package:topwr/widgets/my_splash_tile.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: MySplashTile)
Widget useCaseMySplashTile(BuildContext context) {
  return const MySplashTile(child: SizedBox.square(dimension: 40));
}
