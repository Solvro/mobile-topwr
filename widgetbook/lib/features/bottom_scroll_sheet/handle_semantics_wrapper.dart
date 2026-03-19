import "package:flutter/widgets.dart";
import "package:topwr/features/bottom_scroll_sheet/drag_handle.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: HandleSemanticsWrapper)
Widget useCaseHandleSemanticsWrapper(BuildContext context) {
  return const HandleSemanticsWrapper(child: SizedBox(width: 100, height: 100));
}
