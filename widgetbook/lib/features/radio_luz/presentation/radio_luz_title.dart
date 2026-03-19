import "package:flutter/widgets.dart";
import "package:topwr/features/radio_luz/presentation/radio_luz_title.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: RadioLuzTitle)
Widget useCaseRadioLuzTitle(BuildContext context) {
  return const RadioLuzTitle(title: "Sample Title");
}
