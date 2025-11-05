import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../utils/context_extensions.dart";
import "../data/model/branch.dart";
import "../data/repository/branch_repository.dart";
import "widgets/branch_base_dialog.dart";

class BranchDialog extends ConsumerWidget {
  const BranchDialog({required this.isFirstTimeMode, super.key});

  final bool isFirstTimeMode;

  static Future<String?> show(BuildContext context, {bool isFirstTimeMode = false}) {
    return showDialog<String>(
      context: context,
      builder: (context) => BranchDialog(isFirstTimeMode: isFirstTimeMode),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedBranch = ref.watch(branchRepositoryProvider).value ?? (isFirstTimeMode ? Branch.main : null);

    return BranchBaseDialog(
      title: isFirstTimeMode ? context.localize.pick_branch : context.localize.branch,
      selectedBranch: selectedBranch,
      centerTitle: isFirstTimeMode,
      showApplyButton: isFirstTimeMode,
      applyButtonText: context.localize.select,
      onApplyButtonPressed: () async {
        await ref.read(branchRepositoryProvider.notifier).setBranch(selectedBranch ?? Branch.main);
      },
      onBranchTap: (branch) async {
        if (!isFirstTimeMode) {
          Navigator.pop(context, branch.name);
        } else {
          await ref.read(branchRepositoryProvider.notifier).setBranch(branch);
        }
      },
    );
  }
}
