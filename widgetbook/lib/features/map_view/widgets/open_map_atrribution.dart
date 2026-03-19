import "package:flutter/widgets.dart";
import "package:topwr/features/map_view/widgets/map_atrribution.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: OpenMapAtrribution)
Widget useCaseOpenMapAtrribution(BuildContext context) {
  return const OpenMapAtrribution();
}
