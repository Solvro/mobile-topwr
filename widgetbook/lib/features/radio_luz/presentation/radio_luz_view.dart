import "package:flutter/widgets.dart";
import "package:topwr/features/radio_luz/presentation/radio_luz_view.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: RadioLuzView)
Widget useCaseRadioLuzView(BuildContext context) {
  return const RadioLuzView();
}
