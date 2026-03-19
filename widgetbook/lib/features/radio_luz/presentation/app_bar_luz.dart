import "package:flutter/widgets.dart";
import "package:topwr/features/radio_luz/presentation/radio_luz_app_bar.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: AppBarLuz)
Widget useCaseAppBarLuz(BuildContext context) {
  return const AppBarLuz();
}
