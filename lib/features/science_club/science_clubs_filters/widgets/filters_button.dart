import "package:flutter/material.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";

class FiltersButton extends StatelessWidget {
  const FiltersButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.isSecondary = false,
  });

  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final bool isSecondary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSecondary ? context.colorScheme.surface : context.colorScheme.primary,
          elevation: 4,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: FilterConfig.radius, // Change this value to adjust the radius
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 5),
            Text(
              text,
              style: context.textTheme.titleLarge?.copyWith(
                color: isSecondary ? context.colorScheme.primary : context.colorScheme.surface,
              ),
            ),
            const SizedBox(width: 5),
            Icon(icon, color: isSecondary ? context.colorScheme.primary : context.colorScheme.surface),
          ],
        ),
      ),
    );
  }
}
