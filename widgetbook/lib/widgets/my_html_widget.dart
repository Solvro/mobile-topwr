import "package:flutter/widgets.dart";
import "package:topwr/widgets/my_html_widget.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: MyHtmlWidget)
Widget useCaseMyHtmlWidget(BuildContext context) {
  return const MyHtmlWidget("<p>Sample text in <b>HTML</b></p>");
}
