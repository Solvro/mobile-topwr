import "package:flutter/widgets.dart";
import "package:topwr/features/map_view/widgets/toolbar.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: Toolbar)
Widget useCaseToolbar(BuildContext context) {
  return const Toolbar();
}
