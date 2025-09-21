import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../digital_guide/tabs/accessibility_dialog/presentation/red_dialog.dart";
import "../buisiness/branch_provider.dart";
import "../model/branch.dart";

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
    const branches = Branch.values;
    final selectedBranch = ref.watch(branchRepositoryProvider).value ?? (isFirstTimeMode ? Branch.main : null);

    return Semantics(
      container: true,
      label: context.localize.dialog_semantics_label,
      child: Focus(
        autofocus: true,
        child: RedDialog(
          centerTitle: isFirstTimeMode,
          title: isFirstTimeMode ? context.localize.pick_branch : context.localize.branch,
          subtitle: null,
          showApplyButton: isFirstTimeMode,
          applyButtonText: context.localize.select,
          onApplyButtonPressed: () async {
            await ref.read(branchRepositoryProvider.notifier).setBranch(selectedBranch ?? Branch.main);
          },
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
                    onTap: () async {
                      if (!isFirstTimeMode) {
                        Navigator.pop(context, branches[index].name);
                      } else {
                        await ref.read(branchRepositoryProvider.notifier).setBranch(branches[index]);
                      }
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
