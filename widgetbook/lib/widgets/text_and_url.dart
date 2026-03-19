import "package:flutter/widgets.dart";
import "package:topwr/widgets/text_and_url_widget.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: TextAndUrl)
Widget useCaseTextAndUrl(BuildContext context) {
  return const TextAndUrl("https://www.google.com", "Google");
}
