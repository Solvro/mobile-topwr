import "package:flutter/cupertino.dart";
import "package:flutter/gestures.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../utils/launch_url_util.dart";

class SksMenuDataSourceLink extends ConsumerWidget {
  const SksMenuDataSourceLink({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text.rich(
        TextSpan(
          text: "${context.localize.data_come_from_website}: ",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          children: [
            TextSpan(
              text:
                  SksMenuConfig.sksDataSource.replaceFirst("https://", "www."),
              style: context.textTheme.bodyOrange.copyWith(
                decoration: TextDecoration.underline,
                decorationColor: context.colorTheme.orangePomegranade,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () async => ref.launch(SksMenuConfig.sksDataSource),
            ),
          ],
        ),
        textAlign: TextAlign.center,
        style: context.textTheme.body,
      ),
    );
  }
}
