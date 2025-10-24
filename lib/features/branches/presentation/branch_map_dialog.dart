import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../digital_guide/tabs/accessibility_dialog/presentation/red_dialog.dart";
import "../business/selected_branch_on_map.dart";
import "../data/model/branch.dart";

class BranchMapDialog extends ConsumerWidget {
  const BranchMapDialog({super.key});

  static Future<String?> show(BuildContext context) {
    return showDialog<String>(context: context, builder: (context) => const BranchMapDialog());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedBranch = ref.watch(selectedBranchOnMapProvider);
    const branches = Branch.values;

    return Semantics(
      container: true,
      label: context.localize.dialog_semantics_label,
      child: Focus(
        autofocus: true,
        child: RedDialog(
          title: context.localize.pick_branch,
          subtitle: null,
          showApplyButton: false,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: branches.length,
            itemBuilder: (context, index) {
              final name = branches[index].localize(context.localize);
              final selected = selectedBranch == branches[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(NavigationTabViewConfig.radius),
                    color: context.colorTheme.greyLight,
                  ),
                  child: ListTile(
                    selected: selected,
                    title: Text(semanticsLabel: name.substring(1), name),
                    trailing: selected ? Icon(Icons.check, color: context.colorTheme.orangePomegranade) : null,
                    onTap: () {
                      ref.read(selectedBranchOnMapProvider.notifier).setBranch(branches[index]);
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
