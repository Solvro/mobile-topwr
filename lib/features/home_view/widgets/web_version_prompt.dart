import "package:flutter/material.dart";
import "package:url_launcher/url_launcher.dart";

import "../../../config/url_config.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../../widgets/my_alert_dialog.dart";

Future<void> showWebVersionDialog(BuildContext context) async {
  await showCustomDialog(
    context: context,
    onConfirmTapped: null,
    confirmText: context.localize.ok,
    dialogSemantics: "wersja webowa",
    dialogContent: const _WebVersionDialogContent(),
    closeText: context.localize.ok,
  );
}

class _WebVersionDialogContent extends StatelessWidget {
  const _WebVersionDialogContent();

  @override
  Widget build(BuildContext context) {
    final textScaler = context.textScaler.clamp(maxScaleFactor: 1.4);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.localize.web_version_dialog_message,
          style: context.textTheme.bodyLarge?.copyWith(color: context.colorScheme.onSurface),
          textScaler: textScaler,
        ),
        const SizedBox(height: 16),
        const Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _StoreTile(icon: Icons.android, label: "Android", storeName: "Google Play", url: UrlConfig.androidStoreUrl),
            _StoreTile(icon: Icons.apple, label: "iOS", storeName: "App Store", url: UrlConfig.iosStoreUrl),
          ],
        ),
      ],
    );
  }
}

class _StoreTile extends StatelessWidget {
  const _StoreTile({required this.icon, required this.label, required this.storeName, required this.url});

  final IconData icon;
  final String label;
  final String storeName;
  final String url;

  @override
  Widget build(BuildContext context) {
    final borderColor = context.colorScheme.primary.withValues(alpha: 0.18);
    final tileColor = context.colorScheme.primary.withValues(alpha: 0.08);
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () => launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication),
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: tileColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: context.colorScheme.primary),
            const SizedBox(width: 10),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: context.textTheme.labelSmall?.copyWith(color: context.colorScheme.primary, letterSpacing: 0.8),
                ),
                Text(storeName, style: context.textTheme.bodyLarge),
              ],
            ),
          ],
        ),
      ),
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
            Text("Wersja webowa", style: context.textTheme.bodyMedium, textScaler: textScaler),
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
      tooltip: tooltip,
      onPressed: () => launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication),
      icon: Icon(icon, color: context.colorScheme.primary),
    );
  }
}
