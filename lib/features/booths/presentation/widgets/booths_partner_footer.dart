import "dart:async";

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../../gen/assets.gen.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../utils/launch_url_util.dart";

class BoothsPartnerFooter extends ConsumerWidget {
  const BoothsPartnerFooter({super.key});

  static const _automatykUrl = "https://automatyk.pwr.edu.pl/";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      top: false,
      child: Semantics(
        button: true,
        label: "${context.localize.booths_sns_cooperation}. $_automatykUrl",
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () async {
            unawaited(HapticFeedback.selectionClick());
            await ref.launch(_automatykUrl);
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.localize.booths_sns_cooperation,
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Assets.png.booths.snsAutomatykLogo.image(
                  semanticLabel: "SNS Automatyk logo",
                  height: context.textScaler.clamp(maxScaleFactor: 1.4).scale(44),
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
