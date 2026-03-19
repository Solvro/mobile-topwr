import "package:flutter/widgets.dart";
import "package:topwr/features/branches/presentation/branches_map_button.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: BranchesButton)
Widget useCaseBranchesButton(BuildContext context) {
  return const BranchesButton();
}
