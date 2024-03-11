import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/context_extensions.dart';

class AboutUsSection extends StatelessWidget {
  const AboutUsSection({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return
      text.isEmpty ? const SizedBox.shrink() :
      Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.localize?.about_us ?? '', style: context.textTheme.headline),
            const SizedBox(height: 16),
            Text(text, style: context.textTheme.body),
          ],
        ),
      );
  }
}