import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/presentation/digital_guide_view.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: DigitalGuideView)
Widget useCaseDigitalGuideView(BuildContext context) {
  return const DigitalGuideView(ourId: "test_id");
}
