import 'package:flutter/material.dart';

import '../../../repositories/getDepartments.graphql.dart';
import '../../../theme/app_theme.dart';

class FacultyCard extends StatelessWidget {
  final Query$GetDepartments$departments? faculty;
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
              faculty!.code,
              style: context.textTheme.headlineWhite,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              faculty!.name,
              style: context.textTheme.bodyWhite,
            )
          ],
        ),
      ),
    );
  }
}
