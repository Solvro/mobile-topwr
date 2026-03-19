import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/data/models/level.dart";
import "package:topwr/features/digital_guide/tabs/adapted_toilets/data/models/adapted_toilet.dart";
import "package:topwr/features/digital_guide/tabs/adapted_toilets/presentation/adapted_toilet_level.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

const _mockLevel = Level(
  id: 1,
  floorNumber: 0,
  translations: LevelTranslations(
    plTranslation: LevelTranslation(name: "Ground Floor", roomNumbersRange: "100-150"),
  ),
  regionIndices: [1],
);

final _mockAdaptedToilet = AdaptedToilet(
  translations: const AdaptedToiletTranslations(
    plTranslation: AdaptedToiletTranslation(
      location: "Main Building, Floor 0",
      toiletDescription: "Accessible toilet with grab bars",
      numberOfCabins: "1",
      isAccessAccessibleForPwdComment: "Yes",
      isNeedAuthorizationComment: "No",
      isAreaAllowingMovementInFrontEntranceComment: "Yes",
      isEntranceGraphicallyMarkedComment: "Yes",
      isMarkedComment: "Yes",
      toiletDimensions: "200x180 cm",
      isFreeSpaceComment: "Yes",
      isGoodFloorWallContrastComment: "Yes",
      isSideManeuveringSpaceComment: "Yes",
      isPulldownHandleComment: "Yes",
      isFixedHandleComment: "Yes",
      isGoodPulldownHandleWallContrastComment: "Yes",
      isMirrorComment: "Yes",
      areClothesHooksComment: "Yes",
      isWastebasketComment: "Yes",
      isTowelDispenserComment: "Yes",
      isHandDryerComment: "Yes",
      washbasinLocationHeight: "80 cm",
      isSpaceUnderWashbasinForWheelchairComment: "Yes",
      isLightSwitchComment: "Yes",
      isGoodLitComment: "Yes",
      comment: "Fully accessible",
    ),
  ),
  isAccessAccessibleForPwd: "Yes",
  hasAdditionalPurpose: 1,
  isNeedAuthorization: "No",
  isEntranceGraphicallyMarked: "Yes",
  isMarked: "Yes",
  isFreeSpace: "Yes",
  isGoodFloorWallContrast: "Yes",
  isSideManeuveringSpace: "Yes",
  isPulldownHandle: "Yes",
  isFixedHandle: "Yes",
  isGoodPulldownHandleWallContrast: "Yes",
  isMirror: "Yes",
  areClothesHooks: "Yes",
  toiletSeatHeight: 45,
  isWastebasket: "Yes",
  isTowelDispenser: "Yes",
  isHandDryer: "Yes",
  isSpaceUnderWashbasinForWheelchair: "Yes",
  isLightSwitch: "Yes",
  isGoodLit: "Yes",
  imagesIndices: IList(const [1, 2]),
  doorsIndices: IList(const [1]),
);

@widgetbook.UseCase(name: "default", type: AdaptedToiletLevel)
Widget useCaseAdaptedToiletLevel(BuildContext context) {
  return AdaptedToiletLevel(level: _mockLevel, adaptedToilets: IList([_mockAdaptedToilet]));
}
