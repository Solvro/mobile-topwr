import "package:flutter/widgets.dart";
import "package:topwr/widgets/search_box.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: SearchBox)
Widget useCaseSearchBox(BuildContext context) {
  return SearchBox(onQueryChanged: (query) {});
}
