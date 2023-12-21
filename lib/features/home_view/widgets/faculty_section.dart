import 'package:flutter/material.dart';

import '../../../models/faculty_model.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/context_extensions.dart';
import 'faculty_box.dart';

class FacultySection extends StatelessWidget {
  const FacultySection({super.key});

  @override
  Widget build(BuildContext context) {
    final faculties = Faculties().getFaculties();
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
                  context.localize!.sections,
                  style: context.textTheme.headline,
                ),
                /// Section headline
                GestureDetector(
                  onTap: () {},
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
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: faculties.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    FacultyBox(
                      sectionName: faculties[index].sectionName,
                      sectionShortcut: faculties[index].sectionShortcut,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
