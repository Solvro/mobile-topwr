import "package:html/parser.dart";

extension HtmlToPlainTextX on String {
  String parseHtmlString() {
    final String parsedString = parse(this).documentElement?.text ?? "";
    return parsedString;
  }
}
