import "package:flutter/material.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../data/model/branch.dart";
import "branch_icon.dart";

class BranchList extends StatelessWidget {
  const BranchList({required this.selectedBranch, required this.onBranchTap, super.key});

  final Branch? selectedBranch;
  final ValueChanged<Branch> onBranchTap;

  @override
  Widget build(BuildContext context) {
    const branches = Branch.values;

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 16),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: branches.length,
      itemBuilder: (context, index) {
        final branch = branches[index];
        final name = branch.localize(context.localize);
        final selected = selectedBranch == branch;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(NavigationTabViewConfig.radius),
              color: context.colorScheme.surfaceTint,
            ),
            child: ListTile(
              selected: selected,
              leading: BranchIcon(branch: branch, isEnabled: selected),
              title: Text(semanticsLabel: name.substring(1), name),
              trailing: selected ? Icon(Icons.check, color: context.colorScheme.primary) : null,
              onTap: () => onBranchTap(branch),
            ),
          ),
        );
      },
    );
  }
}
