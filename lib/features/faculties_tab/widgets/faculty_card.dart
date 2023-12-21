import 'package:flutter/material.dart';

import '../../../models/faculty_model.dart';
import '../../../theme/app_theme.dart';

class FacultyCard extends StatelessWidget {
  final FacultyModel faculty;
  const FacultyCard({super.key, required this.faculty});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              faculty.sectionShortcut,
              style: context.textTheme.headlineWhite,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              faculty.sectionName,
              style: context.textTheme.bodyWhite,
            )
          ],
        ),
      ),
    );
  }
}
