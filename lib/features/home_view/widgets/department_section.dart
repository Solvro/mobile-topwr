import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/context_extensions.dart';
import '../../../widgets/loading_widget.dart';
import '../../bottom_nav_bar/bottom_nav_bar_controller.dart';
import '../repositories/departments_repository.dart';
import 'deparment_box.dart';

class DepartmentSection extends ConsumerWidget {
  const DepartmentSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(departmentsRepositoryProvider);
    return Padding(
      padding: const EdgeInsets.only(left: 24.0),
      child: Column(
        children: [
          const _SubsectionHeader(),
          SizedBox(
              height: 120,
              child: switch (state) {
                AsyncLoading() => const LoadingWidget(),
                AsyncError(:final error) => ErrorWidget(error),
                AsyncValue(:final value) => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: value!.length,
                    itemBuilder: (context, index) {
                     final department = value[index];
                      if (department == null) return const SizedBox.shrink();
                      return Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: DepartmentBox(department),
                      );
                    },
                  ),
              })
        ],
      ),
    );
  }
}

class _SubsectionHeader extends ConsumerWidget {
  const _SubsectionHeader();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(right: 24.0, bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            context.localize!.departments,
            style: context.textTheme.headline,
          ),
          TextButton(
            onPressed: () {
              ref
                  .read(bottomNavBarControllerProvider.notifier)
                  .onIndexChanged(2);
            },
            child: Row(
              children: [
                Text(
                  context.localize!.list,
                  style: context.textTheme.boldBodyOrange,
                ),
                const SizedBox(width: 12),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: context.colorTheme.orangePomegranade,
                  size: 8,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
