import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config.dart';
import '../../theme/app_theme.dart';
import '../../utils/context_extensions.dart';
import '../../utils/where_non_null_iterable.dart';
import '../../widgets/my_error_widget.dart';
import '../../widgets/search_box_app_bar.dart';
import 'departments_tab_controller.dart';
import 'repositories/departments_repository.dart';
import 'widgets/department_card.dart';
import 'widgets/departments_list_loading.dart';

class DepartmentTab extends ConsumerWidget {
  const DepartmentTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: SearchBoxAppBar(
        context,
        title: context.localize?.departments ?? "",
        onQueryChanged: (query) {
          ref
              .read(searchDepartmentsControllerProvider.notifier)
              .onTextChanged(query);
        },
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
          AsyncValue(:final value) => value?.isEmpty == true
              ? Center(
                  child: Text(
                    context.localize!.department_not_found,
                    style: context.textTheme.body,
                  ),
                )
              : _DepartmntsDataView(value.whereNonNull.toList()),
        });
  }
}

class _DepartmntsDataView extends StatelessWidget {
  const _DepartmntsDataView(this.departments);

  final List<Department> departments;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: DepartmentsConfig.departmentsTabGridDelegate,
      itemCount: departments.length,
      itemBuilder: (context, index) => DepartmentCard(departments[index]),
    );
  }
}
