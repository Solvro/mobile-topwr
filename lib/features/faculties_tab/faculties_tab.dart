import 'package:flutter/material.dart';

import '../../models/faculty_model.dart';
import '../../theme/app_theme.dart';
import '../../utils/context_extensions.dart';
import 'widgets/search_widget.dart';

class FacultiesTab extends StatelessWidget {
  const FacultiesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final faculties = Faculties().getFaculties();
    return SafeArea(
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
            ListView.builder(
              itemCount: faculties.length,
              itemBuilder: (BuildContext context, int inderx) {
                
              },
            )
          ],
        ),
      ),
    );
  }
}
