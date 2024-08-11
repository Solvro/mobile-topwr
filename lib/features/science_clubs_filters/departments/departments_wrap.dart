import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../utils/where_non_null_iterable.dart";
import "../../departments_view/repository/departments_extensions.dart";
import "../../departments_view/repository/departments_repository.dart";
import "../widgets/chips_loading.dart";
import "../widgets/filter_chip.dart";
import "controller/selected_department.dart";

class DepartmentsWrap extends ConsumerWidget {
  const DepartmentsWrap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final departments = ref.watch(departmentsRepositoryProvider);
    return switch (departments) {
      AsyncLoading() => const FilterChipsLoading(),
      AsyncError() => const SizedBox.shrink(),
      AsyncValue(:final value) => Wrap(
          children: [
            for (final department in value.whereNonNull)
              Consumer(
                builder: (context, ref, child) => MyFilterChip(
                  label: department.code,
                  onTap: () => ref
                      .read(selectedDepartmentControllerProvider.notifier)
                      .toggleDepartment(department),
                  selected: ref.watch(
                    selectedDepartmentControllerProvider.select(
                      (value) => value.contains(department),
                    ), // state slicing
                  ),
                  selectedColor: department.gradient.colors.first,
                  selectedBorderColor: department.gradient.colors.last,
                ),
              ),
          ],
        )
    };
  }
}
