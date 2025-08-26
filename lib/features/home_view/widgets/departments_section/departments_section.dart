import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../utils/context_extensions.dart";
import "../../../../widgets/my_error_widget.dart";
import "../../../../widgets/subsection_header.dart";
import "../../../departments/departments_view/data/models/department.dart";
import "../../../departments/departments_view/data/repository/departments_repository.dart";
import "../../../navigator/utils/navigation_commands.dart";
import "../loading_widgets/scrollable_section_loading.dart";
import "../paddings.dart";
import "deparment_home_tile.dart";

class DepartmentsSection extends ConsumerWidget {
  const DepartmentsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(departmentsRepositoryProvider);
    return Column(
      children: [
        SubsectionHeader(
          title: context.localize.departments,
          actionTitle: context.localize.list,
          onClick: ref.navigateDepartments,
        ),
        SmallHorizontalPadding(
          child: switch (state) {
            AsyncError(:final error, :final stackTrace) => MyErrorWidget(error, stackTrace: stackTrace),
            AsyncValue(:final IList<Department> value) => SizedBox(height: 120, child: _DepartmentsDataList(value)),
            _ => const MediumLeftPadding(child: ScrollableSectionLoading()),
          },
        ),
      ],
    );
  }
}

class _DepartmentsDataList extends ConsumerWidget {
  const _DepartmentsDataList(this.departments);

  final IList<Department> departments;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: departments.length,
      itemBuilder: (context, index) {
        final department = departments[index];
        final departmentCard = _BuildDepartmentCard(department: department, ref: ref);

        if (index != departments.length - 1) {
          return MediumLeftPadding(child: departmentCard);
        } else {
          return MediumHorizontalPadding(child: departmentCard);
        }
      },
    );
  }
}

class _BuildDepartmentCard extends StatelessWidget {
  const _BuildDepartmentCard({required this.department, required this.ref});

  final Department department;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return DepartmentHomeTile(department, onClick: () => ref.navigateDepartmentDetail(department.id));
  }
}
