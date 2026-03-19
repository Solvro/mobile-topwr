import "package:flutter/widgets.dart";
import "package:topwr/features/sks/sks_menu/presentation/sks_menu_screen.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: SksMenuView)
Widget useCaseSksMenuView(BuildContext context) {
  return const SksMenuView();
}
