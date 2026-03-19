import "package:flutter/widgets.dart";
import "package:topwr/features/branches/presentation/branch_map_dialog.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: BranchMapDialog)
Widget useCaseBranchMapDialog(BuildContext context) {
  return const BranchMapDialog();
}
