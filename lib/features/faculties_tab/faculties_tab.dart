import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/faculty_model.dart';
import '../../theme/app_theme.dart';
import '../../utils/context_extensions.dart';
import 'repositories/faculties_list_provider.dart';
import 'widgets/faculty_card.dart';
import 'widgets/search_widget.dart';

class FacultiesTab extends ConsumerWidget {
  const FacultiesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final faculties = ref.watch(filteredListProvider);
    return SafeArea(
      child: SingleChildScrollView(
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
              for (FacultyModel faculty in faculties)
                Column(
                  children: [
                    FacultyCard(faculty: faculty),
                    const SizedBox(height: 16),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
