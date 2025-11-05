import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../utils/context_extensions.dart";
import "../business/selected_branch_on_map.dart";
import "widgets/branch_base_dialog.dart";

class BranchMapDialog extends ConsumerWidget {
  const BranchMapDialog({super.key});

  static Future<String?> show(BuildContext context) {
    return showDialog<String>(context: context, builder: (context) => const BranchMapDialog());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedBranch = ref.watch(selectedBranchOnMapProvider);

    return BranchBaseDialog(
      title: context.localize.pick_branch,
      selectedBranch: selectedBranch,
      onBranchTap: (branch) {
        ref.read(selectedBranchOnMapProvider.notifier).setBranch(branch);
        Navigator.pop(context);
      },
    );
  }
}
