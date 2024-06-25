import 'package:flutter/material.dart';

import 'template_section.dart';

class AboutUsSection extends StatelessWidget {
  const AboutUsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const TemplateSection(
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
