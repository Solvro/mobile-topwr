import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utils/context_extensions.dart';
import '../loading_widgets/scrollable_section_loading.dart';
import '../../../../widgets/subsection_header.dart';
import '../../repositories/departments_repository/departments_repository.dart';
import 'deparment_box.dart';

class DepartmentSection extends ConsumerWidget {
  const DepartmentSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(departmentsRepositoryProvider);
    return Column(
      children: [
        SubsectionHeader(
          title: context.localize!.departments,
          actionTitle: context.localize!.list,
          onClick: () => {}
        ),
        Padding(
          padding: const EdgeInsets.only(left: 6),
          child: SizedBox(
              height: 120,
              child: switch (state) {
                AsyncLoading() => const Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: ScrollableSectionLoading(),
                ),
                AsyncError(:final error) => ErrorWidget(error),
                AsyncValue(:final value) => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: value!.length,
                    itemBuilder: (context, index) {
                      final department = value[index];
                      if (department == null) return const SizedBox.shrink();
                      return Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: DepartmentBox(department),
                      );
                    },
                  ),
              }),
        )
      ],
    );
  }
}
