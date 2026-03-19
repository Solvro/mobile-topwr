import "package:flutter/widgets.dart";
import "package:topwr/features/guide_detail_view/widgets/faq_expansion_tile.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: FaqExpansionTile)
Widget useCaseFaqExpansionTile(BuildContext context) {
  return const FaqExpansionTile(description: "Description", title: "Sample Title");
}
