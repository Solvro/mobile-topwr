import "package:flutter/material.dart";

import "../../../config/url_config.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../../widgets/my_alert_dialog.dart";
import "../../../widgets/store_tile.dart";

Future<void> showRateStoreDialog(BuildContext context) async {
  await showCustomDialog(
    context: context,
    onConfirmTapped: null,
    confirmText: context.localize.ok,
    dialogSemantics: "rate store",
    dialogContent: const RateStoreDialogContent(),
    closeText: context.localize.close,
    maxWidth: 560,
  );
}

class RateStoreDialogContent extends StatelessWidget {
  const RateStoreDialogContent({super.key});

  @override
  Widget build(BuildContext context) {
    final textScaler = context.textScaler.clamp(maxScaleFactor: 1.4);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colorScheme.primary.withValues(alpha: 0.12),
              ),
              child: Icon(Icons.star, semanticLabel: "", size: 20, color: context.colorScheme.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                context.localize.rate_store_dialog_title,
                style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                textScaler: textScaler,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          context.localize.rate_store_dialog_message,
          style: context.textTheme.bodyLarge?.copyWith(color: context.colorScheme.onSurface, height: 1.4),
          textScaler: textScaler,
        ),
        const SizedBox(height: 18),
        const StoreTile(
          icon: Icons.android,
          label: "Android",
          storeName: "Google Play",
          url: UrlConfig.androidStoreUrl,
        ),
        const SizedBox(height: 12),
        const StoreTile(icon: Icons.apple, label: "iOS", storeName: "App Store", url: UrlConfig.iosStoreUrl),
      ],
    );
  }
}
