import "package:flutter/widgets.dart";
import "package:topwr/features/guide_detail_view/guide_detail_view.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: GuideDetailView)
Widget useCaseGuideDetailView(BuildContext context) {
  return const GuideDetailView(id: 1);
}
