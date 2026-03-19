import "package:flutter/widgets.dart";
import "package:topwr/features/guide_view/guide_view.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: GuideView)
Widget useCaseGuideView(BuildContext context) {
  return const GuideView();
}
