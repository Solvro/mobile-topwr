import "package:flutter/widgets.dart";
import "package:topwr/widgets/search_not_found.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: SearchNotFound)
Widget useCaseSearchNotFound(BuildContext context) {
  return const SearchNotFound(message: "Sample message");
}
