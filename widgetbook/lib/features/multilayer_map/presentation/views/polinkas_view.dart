import "package:flutter/widgets.dart";
import "package:topwr/features/multilayer_map/presentation/views/redirect_views.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: PolinkasView)
Widget useCasePolinkasView(BuildContext context) {
  return const PolinkasView();
}
