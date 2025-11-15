import "dart:async";

import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../utils/context_extensions.dart";
import "../../../analytics/data/clarity.dart";
import "../../../analytics/data/clarity_events.dart";
import "../../../departments/departments_view/data/models/department.dart";
import "../../../departments/departments_view/data/utils/departments_extensions.dart";
import "../filters_controller.dart";
import "../filters_search_controller.dart";
import "../filters_sheet.dart";
import "../utils.dart";
import "chips_loading.dart";
import "filter_chip.dart";

class DepartmentsWrap extends ConsumerWidget {
  const DepartmentsWrap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final departments = ref.watch(departmentFiltersFilteredProvider);
    return switch (departments) {
      AsyncError() => const SizedBox.shrink(),
      AsyncValue(:final IList<Department> value) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (value.isNotEmpty) FiltersSectionHeader(context.localize.departments),
          Wrap(
            runSpacing: context.isTextScaledDown ? 0 : 8,
            children: [
              for (final department in value)
                Consumer(
                  builder: (context, ref, child) {
                    final controller = ref.watch(selectedDepartmentControllerProvider.notifier);
                    final isSelected = ref.watchContains(selectedDepartmentControllerProvider, department);
                    return MyFilterChip(
                      label: department.code,
                      onTap: () {
                        unawaited(ref.trackEvent(ClarityEvents.selectSciClubFilterDepartment, value: department.code));
                        controller.toggleFilter(department);
                      },
                      selected: isSelected,
                      selectedColor: department.gradient.colors.first,
                      selectedBorderColor: department.gradient.colors.last,
                      tooltip: department.name,
                    );
                  },
                ),
            ],
          ),
        ],
      ),
      _ => const FilterChipsLoading(),
    };
  }
}
