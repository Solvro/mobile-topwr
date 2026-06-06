import "dart:async";

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../utils/context_extensions.dart";
import "../../../analytics/data/clarity.dart";
import "../../../analytics/data/clarity_events.dart";
import "../../../departments/departments_view/data/utils/departments_extensions.dart";
import "../../science_clubs_view/model/branch_department_data.dart";
import "../filters_controller.dart";
import "../filters_search_controller.dart";
import "../filters_sheet.dart";
import "chips_loading.dart";
import "filter_chip.dart";

class DepartmentsWrap extends ConsumerWidget {
  const DepartmentsWrap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final departments = ref.watch(branchDepartmentFilteredHelperProvider(context.localize));
    return switch (departments) {
      AsyncError() => const SizedBox.shrink(),
      AsyncValue(:final BranchDepartmentData value) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (value.departments.isNotEmpty) FiltersSectionHeader(context.localize.departments),
          Consumer(
            builder: (context, ref, child) {
              final controller = ref.watch(selectedDepartmentControllerProvider.notifier);
              final selectedDepartments = ref.watch(selectedDepartmentControllerProvider);
              return RepaintBoundary(
                child: Wrap(
                  runSpacing: context.isTextScaledDown ? 0 : 8,
                  children: [
                    for (final department in value.departments)
                      MyFilterChip(
                        label: department.code,
                        onTap: () {
                          unawaited(HapticFeedback.selectionClick());
                          unawaited(
                            ref.trackEvent(ClarityEvents.selectSciClubFilterDepartment, value: department.code),
                          );
                          controller.toggleFilter(department);
                        },
                        selected: selectedDepartments.contains(department),
                        selectedColor: department.gradient.colors.first,
                        selectedBorderColor: department.gradient.colors.last,
                        tooltip: department.name,
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
