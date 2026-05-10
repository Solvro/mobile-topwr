import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:url_launcher/url_launcher.dart";

import "../../../config/url_config.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../../widgets/my_alert_dialog.dart";
import "../../../widgets/store_tile.dart";

Future<void> showWebVersionDialog(BuildContext context) async {
  await showCustomDialog(
    context: context,
    onConfirmTapped: null,
    confirmText: context.localize.ok,
    dialogSemantics: "wersja webowa",
    dialogContent: const WebVersionDialogContent(),
    closeText: context.localize.ok,
    maxWidth: 560,
  );
}

class WebVersionDialogContent extends StatelessWidget {
  const WebVersionDialogContent({super.key});

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
              child: Icon(Icons.language, size: 20, color: context.colorScheme.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "ToPWR Web",
                style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                textScaler: textScaler,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          context.localize.web_version_dialog_message,
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

class WebVersionBanner extends StatelessWidget {
  const WebVersionBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final textScaler = context.textScaler.clamp(maxScaleFactor: 1.2);
    return Material(
      color: context.colorScheme.surface,
      elevation: 6,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: context.colorScheme.primary.withValues(alpha: 0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.language, size: 18, color: context.colorScheme.primary),
            const SizedBox(width: 8),
            InkWell(
              onTap: () => showWebVersionDialog(context),
              borderRadius: BorderRadius.circular(16), // match the container
              child: Text(
                context.localize.web_version_banner,
                style: context.textTheme.bodyMedium,
                textScaler: textScaler,
              ),
            ),
            const SizedBox(width: 8),
            const _BannerIconButton(icon: Icons.android, tooltip: "Google Play", url: UrlConfig.androidStoreUrl),
            const SizedBox(width: 4),
            const _BannerIconButton(icon: Icons.apple, tooltip: "App Store", url: UrlConfig.iosStoreUrl),
          ],
        ),
      ),
    );
  }
}

class _BannerIconButton extends StatelessWidget {
  const _BannerIconButton({required this.icon, required this.tooltip, required this.url});

  final IconData icon;
  final String tooltip;
  final String url;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      visualDensity: VisualDensity.compact,
      iconSize: 18,
      tooltip: kIsWeb ? null : tooltip,
      onPressed: () => launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication),
      icon: Icon(icon, color: context.colorScheme.primary),
    );
  }
}
