import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/tabs/lodge/data/models/digital_guide_lodge.dart";
import "package:topwr/features/digital_guide/tabs/structure/presentation/views/lodge_view.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: LodgeView)
Widget useCaseLodgeView(BuildContext context) {
  const mockLodge = DigitalGuideLodge(
    id: 1,
    translations: DigitalGuideTranslationsLodge(
      pl: DigitalGuideTranslationLodge(
        location: "Mock Location",
        workingDaysAndHours: "Mon-Fri 9am-5pm",
        comment: "Sample lodge comment.",
        areAccessBarriersComment: "No access barriers found.",
        isMovementSpaceComment: "There is enough space for movement.",
        isSpaceUnderCounterComment: "Space under counter is sufficient.",
        isVisibleFromAfarComment: "Lodge is clearly visible from a distance.",
        isGoodLitComment: "Area is well-lit during operational hours.",
      ),
    ),
    areAccessBarriers: "no",
    isMovementSpace: "yes",
    counterHeight: 0.95,
    isSpaceUnderCounter: "yes",
    isVisibleFromAfar: "yes",
    isGoodLit: "yes",
    imagesIds: [101, 102, 103],
  );

  return const LodgeView(lodge: mockLodge);
}
