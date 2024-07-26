import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../config/nav_bar_config.dart";
import "../../../../shared_repositories/departments_repository/departments_repository.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../utils/where_non_null_iterable.dart";
import "../../../../widgets/my_error_widget.dart";
import "../../../../widgets/subsection_header.dart";
import "../../../navigator/navigator/detail_view_navigator.dart";
import "../../../navigator/navigator/nested_navigator.dart";
import "../../../navigator/navigator/tab_bar_navigator.dart";
import "../loading_widgets/scrollable_section_loading.dart";
import "../paddings.dart";
import "deparment_box.dart";

class DepartmentSection extends ConsumerWidget {
  const DepartmentSection({super.key});

  static Future<void> goToFacultiesTab(WidgetRef ref) async =>
      ref.read(navigatorProvider).changeTabBar(NavBarEnum.mapp);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(departmentsRepositoryProvider);
    return Column(
      children: [
        SubsectionHeader(
          title: context.localize.departments,
          actionTitle: context.localize.list,
          onClick: () async => goToFacultiesTab(ref),
        ),
        SmallHorizontalPadding(
          child: switch (state) {
            AsyncLoading() => const MediumLeftPadding(
                child: ScrollableSectionLoading(),
              ),
            AsyncError(:final error) => MyErrorWidget(error),
            AsyncValue(:final value) => SizedBox(
                height: 120,
                child: _DepartmentsDataList(value.whereNonNull.toList()),
              ),
          },
        ),
      ],
    );
  }
}

class _DepartmentsDataList extends ConsumerWidget {
  const _DepartmentsDataList(this.departments);

  final List<Department> departments;

  static Future<void> goToDetailView(WidgetRef ref, String id) async {
    await ref.read(navigatorProvider).navigateToDepartmentDetails(id);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: departments.length,
      itemBuilder: (context, index) => MediumLeftPadding(
        child: DepartmentBox(
          departments[index],
          onClick: () async => goToDetailView(ref, departments[index].id),
        ),
      ),
    );
  }
}
