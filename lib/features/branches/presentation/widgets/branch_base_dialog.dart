import "package:flutter/material.dart";

import "../../../../utils/context_extensions.dart";
import "../../../digital_guide/tabs/accessibility_dialog/presentation/red_dialog.dart";
import "../../data/model/branch.dart";
import "branch_list.dart";

class BranchBaseDialog extends StatelessWidget {
  const BranchBaseDialog({
    required this.title,
    required this.selectedBranch,
    required this.onBranchTap,
    this.centerTitle = false,
    this.showApplyButton = false,
    this.applyButtonText,
    this.onApplyButtonPressed,
    super.key,
  });

  final String title;
  final Branch? selectedBranch;
  final ValueChanged<Branch> onBranchTap;
  final bool centerTitle;
  final bool showApplyButton;
  final String? applyButtonText;
  final VoidCallback? onApplyButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: context.localize.dialog_semantics_label,
      child: Focus(
        autofocus: true,
        child: RedDialog(
          centerTitle: centerTitle,
          title: title,
          subtitle: null,
          showApplyButton: showApplyButton,
          applyButtonText: applyButtonText,
          onApplyButtonPressed: onApplyButtonPressed,
          child: BranchList(selectedBranch: selectedBranch, onBranchTap: onBranchTap),
        ),
      ),
    );
  }
}
