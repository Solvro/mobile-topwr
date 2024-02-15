import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/app_theme.dart';
import '../../utils/context_extensions.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/my_error_widget.dart';
import 'departments_tab_controller.dart';
import 'repositories/departments_repository.dart';
import 'widgets/department_card.dart';
import '../../widgets/search_widget.dart';

class DepartmentTab extends ConsumerWidget {
  const DepartmentTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(departmentListProvider);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Text(
              context.localize!.departments,
              style: context.textTheme.headline,
            ),
            const SizedBox(height: 16),
            SearchWidget(
              onQueryChanged: (query) {
                ref
                    .read(searchDepartmentsControllerProvider.notifier)
                    .onTextChanged(query);
              },
            ),
            const SizedBox(height: 47),
            switch (state) {
              AsyncLoading() => const LoadingWidget(),
              AsyncError(:final error) => MyErrorWidget(error),
              AsyncValue(:final value) => value?.isEmpty == true
                  ? Center(
                      child: Text(
                        context.localize!.department_not_found,
                        style: context.textTheme.body,
                      ),
                    )
                  : Column(children: [
                      for (var department in value ?? <Department>[])
                        if (department != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: DepartmentCard(department),
                          ),
                    ]),
            }
          ],
        ),
      ),
    );
  }
}
