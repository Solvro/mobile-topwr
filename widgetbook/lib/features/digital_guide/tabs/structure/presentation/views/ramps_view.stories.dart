import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:topwr/features/digital_guide/tabs/structure/data/models/ramp.dart";
import "package:topwr/features/digital_guide/tabs/structure/presentation/views/ramps_view.dart";
import "package:widgetbook/widgetbook.dart";

part "ramps_view.stories.g.dart";

const _mockRamp = Ramp(
  translations: RampTranslations(
    plTranslation: RampTranslation(
      location: "Side entrance",
      isRampMarkedComment: "",
      isIncreasedForceNeededComment: "",
      isPermanentRampComment: "",
      numberOfLandings: "1",
      dimensionsOfTheLandings: "200×120 cm",
      isGoodLitComment: "",
      areNonslipElementsComment: "",
      comment: "",
    ),
  ),
  isRampMarked: "yes",
  isIncreasedForceNeeded: "no",
  isPermanentRamp: "yes",
  rampWidth: 120,
  isGoodLit: "yes",
  areNonslipElements: "yes",
  railingsIDs: IList.empty(),
);

const meta = Meta<RampsView>();

final $default = RampsViewStory(args: RampsViewArgs(ramps: Arg.fixed(_mockRamp)));
