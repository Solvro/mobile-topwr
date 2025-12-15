import "package:flutter/gestures.dart";
import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../utils/launch_url_util.dart";

class DigitalGuideDataSourceLink extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DigitalGuideConfig.paddingMedium),
      child: Text.rich(
        TextSpan(
          text: "${context.localize.data_come_from_website}: ",
          style: const TextStyle(fontWeight: FontWeight.bold),
          children: [
            TextSpan(
              text: context.localize.digital_guide_website,
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colorScheme.primary,
                decoration: TextDecoration.underline,
                decorationColor: context.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  await ref.launch(context.localize.digital_guide_website.replaceAll("www.", "https://"));
                },
            ),
          ],
        ),
        textAlign: TextAlign.center,
        style: context.textTheme.bodyLarge,
      ),
    );
  }
}
