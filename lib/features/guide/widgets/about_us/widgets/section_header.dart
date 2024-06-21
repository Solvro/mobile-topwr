import 'package:flutter/material.dart';

import '../../../../../config/ui_config.dart';
import '../../../../../theme/app_theme.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AboutUsConfig.defaultPadding,
        top: AboutUsConfig.spacerHeight,
        bottom: AboutUsConfig.defaultPadding,
      ),
      child: Text(
        text,
        style: context.aboutUsTheme.headline,
        maxLines: 2,
      ),
    );
  }
}
