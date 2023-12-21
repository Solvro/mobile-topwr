import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

class FacultyBox extends StatelessWidget {
  final String sectionShortcut;
  final String sectionName;
  const FacultyBox(
      {super.key, required this.sectionShortcut, required this.sectionName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.green,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                sectionShortcut,
                style: context.textTheme.titleWhite,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                sectionName.length > 32
                    ? '${sectionName.substring(0, 28)}...'
                    : sectionName,
                style: context.textTheme.bodyWhite,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
