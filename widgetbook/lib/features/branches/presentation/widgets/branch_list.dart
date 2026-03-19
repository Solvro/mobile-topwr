import "package:flutter/widgets.dart";
import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/branches/presentation/widgets/branch_list.dart";
import "package:widgetbook/widgetbook.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: BranchList)
Widget useCaseBranchList(BuildContext context) {
  return BranchList(
    selectedBranch: context.knobs.objectOrNull.dropdown(label: "Selected branch", options: Branch.values.toList()),
    onBranchTap: (_) {},
  );
}
