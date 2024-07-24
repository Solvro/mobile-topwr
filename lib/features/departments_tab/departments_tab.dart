import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../config/ui_config.dart";
import "../../shared_repositories/departments_repository/departments_repository.dart";
import "../../theme/app_theme.dart";
import "../../utils/context_extensions.dart";
import "../../utils/where_non_null_iterable.dart";
import "../../widgets/my_error_widget.dart";
import "../../widgets/search_box_app_bar.dart";
import "../navigator/navigator/detail_view_navigator.dart";
import "../navigator/navigator/nested_navigator.dart";
import "departments_tab_controller.dart";
import "widgets/department_card.dart";
import "widgets/departments_list_loading.dart";

class DepartmentTab extends ConsumerWidget {
  const DepartmentTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: SearchBoxAppBar(
        context,
        title: context.localize.departments,
        onQueryChanged: ref
            .watch(searchDepartmentsControllerProvider.notifier)
            .onTextChanged,
      ),
      body: const _DepartmentsTabListBody(),
    );
  }
}

class _DepartmentsTabListBody extends ConsumerWidget {
  const _DepartmentsTabListBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(departmentListProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: switch (state) {
        AsyncLoading() => const DepartmentsListLoading(),
        AsyncError(:final error) => MyErrorWidget(error),
        AsyncValue(:final value) =>
          _DepartmentsDataView(value.whereNonNull.toList()),
      },
    );
  }
}

class _DepartmentsDataView extends ConsumerWidget {
  const _DepartmentsDataView(this.departments);
  final List<Department> departments;

  static Future<void> goToDetailView(WidgetRef ref, String id) async {
    await ref.read(navigatorProvider).navigateToDepartmentDetails(id);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (departments.isEmpty) {
      return Center(
        child: Text(
          context.localize.department_not_found,
          style: context.textTheme.body,
        ),
      );
    }
    return GridView.builder(
      padding: const EdgeInsets.only(bottom: 24),
      gridDelegate: DepartmentsConfig.departmentsTabGridDelegate,
      itemCount: departments.length,
      itemBuilder: (context, index) => DepartmentCard(
        departments[index],
        onClick: () async => goToDetailView(ref, departments[index].id),
      ),
    );
  }
}
