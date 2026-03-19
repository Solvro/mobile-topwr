import "package:flutter/widgets.dart";
import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/branches/presentation/widgets/branch_icon.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: BranchIcon)
Widget useCaseBranchIcon(BuildContext context) {
  return const BranchIcon(branch: Branch.main, isEnabled: true);
}
