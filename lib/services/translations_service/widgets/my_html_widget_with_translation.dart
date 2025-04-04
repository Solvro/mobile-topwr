import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../widgets/my_html_widget.dart";
import "../data/repository/translations_repository.dart";

class MyHtmlWidgetWithTranslation extends ConsumerWidget {
  final String html;
  final bool translate;
  final TextStyle? textStyle;

  const MyHtmlWidgetWithTranslation(this.html, {this.translate = true, this.textStyle, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!translate) {
      return MyHtmlWidget(html, textStyle: textStyle);
    }

    final translation = ref.watch(translationsRepositoryProvider(html));

    return MyHtmlWidget(switch (translation) {
      AsyncData(:final value) => value,
      _ => html,
    }, textStyle: textStyle);
  }
}
