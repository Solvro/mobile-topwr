import "package:flutter/widgets.dart";
import "package:topwr/features/branches/presentation/branch_dialog.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: BranchDialog)
Widget useCaseBranchDialog(BuildContext context) {
  return const BranchDialog(isFirstTimeMode: false);
}
