import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class WideTileCard extends StatelessWidget {
  const WideTileCard({
    this.isActive = false,
    required this.title,
    required this.subtitle,
    super.key,
  });

  final String title;
  final String subtitle;

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.colorTheme.greyLight,
      child: ListTile(
        title: Text(
          title,
        ),
        subtitle: Text(
          subtitle,
        ),
        trailing: const SizedBox.square(
          dimension: 92,
          child: Placeholder(),
        ),
      ),
    );
  }
}
