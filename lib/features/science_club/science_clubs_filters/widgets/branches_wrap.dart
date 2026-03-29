import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../utils/context_extensions.dart";
import "../../../analytics/data/clarity.dart";
import "../../../analytics/data/clarity_events.dart";
import "../../science_clubs_view/model/branch_department_data.dart";
import "../filters_controller.dart";
import "../filters_search_controller.dart";
import "../filters_sheet.dart";
import "chips_loading.dart";
import "filter_chip.dart";

class BranchesWrap extends ConsumerWidget {
  const BranchesWrap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final branches = ref.watch(branchDepartmentFilteredHelperProvider(context.localize));
    return switch (branches) {
      AsyncError() => const SizedBox.shrink(),
      AsyncValue(:final BranchDepartmentData value) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (value.branches.isNotEmpty) FiltersSectionHeader(context.localize.branches),
          Consumer(
            builder: (context, ref, child) {
              final controller = ref.watch(selectedBranchControllerProvider.notifier);
              final selectedBranches = ref.watch(selectedBranchControllerProvider);
              return RepaintBoundary(
                child: Wrap(
                  runSpacing: context.isTextScaledDown ? 0 : 8,
                  children: [
                    for (final branch in value.branches)
                      MyFilterChip(
                        label: branch.localize(context.localize),
                        onTap: () {
                          unawaited(ref.trackEvent(ClarityEvents.selectSciClubFilterBranch, value: branch.name));
                          controller.toggleFilter(branch);
                        },
                        selected: selectedBranches.contains(branch),
                        tooltip: branch.localize(context.localize),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      _ => const FilterChipsLoading(),
    };
  }
}
