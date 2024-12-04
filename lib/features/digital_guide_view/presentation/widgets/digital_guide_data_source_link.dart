import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";

class DigitalGuideDataSourceLink extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text.rich(
      TextSpan(
        text: "${context.localize.data_come_from_website}: ",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            // temporary hardcoded link
            text: "www.przewodnik.pwr.edu.pl",
            style: context.textTheme.bodyOrange.copyWith(
              decoration: TextDecoration.underline,
              decorationColor: context.colorTheme.orangePomegranade,
              fontWeight: FontWeight.bold,
            ),
            //onTap ->
          ),
        ],
      ),
      textAlign: TextAlign.center,
      style: context.textTheme.body,
    );
  }
}
