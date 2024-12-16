import "package:flutter/cupertino.dart";
import "package:flutter/gestures.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../theme/app_theme.dart";
import "../utils/launch_url_util.dart";

class TextAndUrl extends ConsumerWidget {
  const TextAndUrl(
    this.url,
    this.text, {
    super.key,
  });

  final String url;
  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text.rich(
        TextSpan(
          text: text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          children: [
            TextSpan(
              text: url.replaceFirst("https://", " www."),
              style: context.textTheme.bodyOrange.copyWith(
                decoration: TextDecoration.underline,
                decorationColor: context.colorTheme.orangePomegranade,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () async => ref.launch(url),
            ),
          ],
        ),
        textAlign: TextAlign.center,
        style: context.textTheme.body,
      ),
    );
  }
}
