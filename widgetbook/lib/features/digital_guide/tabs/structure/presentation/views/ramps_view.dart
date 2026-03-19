import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/tabs/structure/data/models/ramp.dart";
import "package:topwr/features/digital_guide/tabs/structure/presentation/views/ramps_view.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: RampsView)
Widget useCaseRampsView(BuildContext context) {
  return const RampsView(
    ramps: Ramp(
      translations: RampTranslations(
        plTranslation: RampTranslation(
          location: "Entrance A",
          isRampMarkedComment: "Clear signage.",
          isIncreasedForceNeededComment: "Normal effort required.",
          isPermanentRampComment: "Permanent structure.",
          numberOfLandings: "2",
          dimensionsOfTheLandings: "2x2m",
          isGoodLitComment: "Well lit.",
          areNonslipElementsComment: "Anti-slip present.",
          comment: "No further notes.",
        ),
      ),
      isRampMarked: "Yes",
      isIncreasedForceNeeded: "No",
      isPermanentRamp: "Yes",
      rampWidth: 1.2,
      isGoodLit: "Yes",
      areNonslipElements: "Yes",
      railingsIDs: IListConst([1, 2]),
    ),
  );
}
