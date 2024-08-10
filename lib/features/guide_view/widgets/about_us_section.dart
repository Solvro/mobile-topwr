import 'package:flutter/material.dart';

import 'template_section.dart';

class GuideAboutUsSection extends StatelessWidget {
  const GuideAboutUsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const GuideTemplateSection(
      title: 'O Nas!',
      description: 'Poznaj twórców, którzy razem stworzyli te aplikacje!',
      imagePath: "",
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.red,
      ),
    );
  }
}
