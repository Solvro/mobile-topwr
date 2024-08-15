import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../departments_view/repository/departments_extensions.dart";
import "../../departments_view/repository/departments_repository.dart";
import "../filters_controller.dart";
import "../filters_search_controller.dart";
import "chips_loading.dart";
import "filter_chip.dart";

class DepartmentsWrap extends ConsumerWidget {
  const DepartmentsWrap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final departments = ref.watch(departmentFiltersFilteredProvider);
    return switch (departments) {
      AsyncError() => const SizedBox.shrink(),
      AsyncValue(:final IList<Department> value) => Wrap(
          children: [
            for (final department in value)
              Consumer(
                builder: (context, ref, child) {
                  final controller =
                      ref.watch(selectedDepartmentControllerProvider.notifier);
                  final isSelected = ref.watchContains(
                    selectedDepartmentControllerProvider,
                    department,
                  );
                  return MyFilterChip(
                    label: department.betterCode ?? department.code,
                    onTap: () => controller.toggleFilter(department),
                    selected: isSelected,
                    selectedColor: department.gradient.colors.first,
                    selectedBorderColor: department.gradient.colors.last,
                  );
                },
              ),
          ],
        ),
      _ => const FilterChipsLoading(),
    };
  }
}
