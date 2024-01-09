import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.sectionTitle,
    required this.buttonTitle,
    required this.onPressed,
  });

  final String sectionTitle;
  final String buttonTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(children: [
          Text(sectionTitle, style: context.textTheme.headline),
          const Spacer(),
          GestureDetector(
            onTap: onPressed,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                buttonTitle,
                style: context.textTheme.boldBodyOrange,
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right,
                color: context.colorTheme.orangePomegranade,
                size: 16,
              )
            ]),
          )
        ])
    );
  }
}
