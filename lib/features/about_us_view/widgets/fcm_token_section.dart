import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../theme/app_theme.dart";
import "../data/fcm_token_provider.dart";

class FcmTokenSection extends ConsumerWidget {
  const FcmTokenSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokenAsync = ref.watch(fcmTokenProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("FCM token", style: context.textTheme.titleMedium),
        const SizedBox(height: 6),
        tokenAsync.when(
          loading: () => const SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2)),
          error: (_, _) =>
              Text("Not available", style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.outline)),
          data: (token) {
            if (token == null || token.isEmpty) {
              return Text(
                "Not available",
                style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.outline),
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SelectableText(
                    token,
                    style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.outline),
                  ),
                ),
                IconButton(
                  tooltip: "Copy",
                  icon: const Icon(Icons.copy, size: 20),
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: token));
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("FCM token copied")));
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
