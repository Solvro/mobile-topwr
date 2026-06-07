import "package:flutter/material.dart";
import "package:url_launcher/url_launcher.dart";

import "../services/haptics/app_haptics.dart";
import "../theme/app_theme.dart";

class StoreTile extends StatelessWidget {
  const StoreTile({super.key, required this.icon, required this.label, required this.storeName, required this.url});

  final IconData icon;
  final String label;
  final String storeName;
  final String url;

  @override
  Widget build(BuildContext context) {
    final accent = context.colorScheme.primary;
    final borderColor = accent.withValues(alpha: 0.18);
    final tileColor = accent.withValues(alpha: 0.08);
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: AppHaptics.wrapperLight(() async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      }),
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: tileColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor),
          boxShadow: [BoxShadow(color: accent.withValues(alpha: 0.12), blurRadius: 16, offset: const Offset(0, 6))],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(shape: BoxShape.circle, color: accent.withValues(alpha: 0.16)),
              child: Icon(icon, semanticLabel: "", size: 22, color: accent),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label.toUpperCase(),
                    style: context.textTheme.labelSmall?.copyWith(
                      color: accent,
                      letterSpacing: 1.1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(storeName, style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward, semanticLabel: "", size: 18, color: accent.withValues(alpha: 0.7)),
          ],
        ),
      ),
    );
  }
}
