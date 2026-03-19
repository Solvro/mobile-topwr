import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide_objects/presentation/digital_guide_object_view.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: DigitalGuideObjectView)
Widget useCaseDigitalGuideObjectView(BuildContext context) {
  return const DigitalGuideObjectView(ourId: "1");
}
