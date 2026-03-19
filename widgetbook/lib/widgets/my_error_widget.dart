import "package:flutter/widgets.dart";
import "package:topwr/widgets/my_error_widget.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: MyErrorWidget)
Widget useCaseMyErrorWidget(BuildContext context) {
  return const MyErrorWidget(null, stackTrace: null);
}
