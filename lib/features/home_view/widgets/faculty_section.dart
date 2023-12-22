import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../repositories/departments_repository.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/context_extensions.dart';
import '../../../widgets/loading_widget.dart';
import '../../bottom_nav_bar/bottom_nav_bar_controller.dart';
import 'faculty_box.dart';

class FacultySection extends ConsumerWidget {
  const FacultySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(departmentsRepositoryProvider);
    return Padding(
      padding: const EdgeInsets.only(left: 24.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
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
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
              height: 120,
              child: switch (state) {
                AsyncLoading() => const LoadingWidget(),
                AsyncError(:final error) => ErrorWidget(error),
                AsyncValue(:final value) => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: value!.length,
                    itemBuilder: (context, index) {
                      return FacultyBox(
                        sectionName: value[index]!.name,
                        code: value[index]!.code,
                      );
                    },
                  ),
              })
        ],
      ),
    );
  }
}
