import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/app_theme.dart';
import '../../utils/context_extensions.dart';
import '../../widgets/loading_widget.dart';
import 'repositories/faculties_list_provider.dart';
import 'widgets/faculty_card.dart';
import 'widgets/search_widget.dart';

class FacultiesTab extends ConsumerWidget {
  const FacultiesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(filteredListProvider);
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
            const SearchWidget(),
            const SizedBox(height: 47),
            switch (state) {
              AsyncLoading() => const LoadingWidget(),
              AsyncError(:final error) => ErrorWidget(error),
              AsyncValue(:final value) => Column(
                  children: value!.isEmpty
                      ? [
                          Center(
                            child: Text(
                              context.localize!.department_not_found,
                              style: context.textTheme.body,
                            ),
                          )
                        ]
                      : value
                          .map(
                            (faculty) => Column(
                              children: [
                                FacultyCard(faculty: faculty),
                                const SizedBox(height: 16),
                              ],
                            ),
                          )
                          .toList(),
                ),
            }
          ],
        ),
      ),
    );
  }
}
