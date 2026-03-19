import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/presentation/widgets/digital_guide_image.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: DigitalGuideImage)
Widget useCaseDigitalGuideImage(BuildContext context) {
  return const DigitalGuideImage(id: 1);
}
