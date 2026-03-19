import "package:flutter/widgets.dart";
import "package:topwr/widgets/my_text_button.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: MyTextButton)
Widget useCaseMyTextButton(BuildContext context) {
  return const MyTextButton(actionTitle: "Sample action title");
}
