import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/tabs/structure/presentation/views/stairs_view.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: StairsView)
Widget useCaseStairsView(BuildContext context) {
  return const StairsView(stairsId: 1);
}
