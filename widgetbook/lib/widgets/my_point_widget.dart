import "package:flutter/widgets.dart";
import "package:topwr/widgets/my_point_widget.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: MyPointWidget)
Widget useCaseMyPointWidget(BuildContext context) {
  return const MyPointWidget(text: "Sample text");
}
