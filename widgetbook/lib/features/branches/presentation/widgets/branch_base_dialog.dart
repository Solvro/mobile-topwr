import "package:flutter/widgets.dart";
import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/branches/presentation/widgets/branch_base_dialog.dart";
import "package:widgetbook/widgetbook.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: BranchBaseDialog)
Widget useCaseBranchBaseDialog(BuildContext context) {
  return BranchBaseDialog(
    title: context.knobs.string(label: "Title", initialValue: "Title"),
    selectedBranch: context.knobs.objectOrNull.dropdown(label: "Selected branch", options: Branch.values.toList()),
    onBranchTap: (_) {},
    centerTitle: context.knobs.boolean(label: "Center title"),
    showApplyButton: context.knobs.boolean(label: "Show apply button"),
    applyButtonText: context.knobs.stringOrNull(label: "Apply button text"),
    onApplyButtonPressed: () {},
  );
}
