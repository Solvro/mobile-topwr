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

  String checkState(List faculties) {
    if (faculties.isEmpty) {
      return 'empty';
    } else if (faculties[0] == null) {
      return 'loading';
    } else if (faculties.isNotEmpty && faculties[0] != null) {
      return 'ready';
    }
    return 'error';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final faculties = ref.watch(filteredListProvider);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Text(
              context.localize!.faculties,
              style: context.textTheme.headline,
            ),
            const SizedBox(height: 16),
            const SearchWidget(),
            const SizedBox(height: 47),
            switch (checkState(faculties)) {
              'empty' => Center(
                  child: Text(
                    'Pusta lista',
                    style: context.textTheme.body,
                  ),
                ),
              'loading' => const LoadingWidget(),
              'error' => ErrorWidget('Error'),
              'ready' => Column(
                  children: faculties
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
              String() => ErrorWidget('Different error'),
            }
          ],
        ),
      ),
    );
  }
}
