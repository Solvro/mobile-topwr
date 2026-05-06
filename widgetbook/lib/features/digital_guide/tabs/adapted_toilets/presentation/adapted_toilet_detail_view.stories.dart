import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:topwr/features/digital_guide/tabs/adapted_toilets/data/models/adapted_toilet.dart";
import "package:topwr/features/digital_guide/tabs/adapted_toilets/presentation/adapted_toilet_detail_view.dart";
import "package:widgetbook/widgetbook.dart";

part "adapted_toilet_detail_view.stories.g.dart";

const mockAdaptedToilet = AdaptedToilet(
  translations: AdaptedToiletTranslations(
    plTranslation: AdaptedToiletTranslation(
      location: "Parter, przy wejściu od strony wybrzeża Wyspiańskiego",
      toiletDescription: "desc",
      numberOfCabins: "1",
      isAccessAccessibleForPwdComment: "",
      isNeedAuthorizationComment: "",
      isAreaAllowingMovementInFrontEntranceComment: "",
      isEntranceGraphicallyMarkedComment: "",
      isMarkedComment: "",
      toiletDimensions: "",
      isFreeSpaceComment: "",
      isGoodFloorWallContrastComment: "",
      isSideManeuveringSpaceComment: "",
      isPulldownHandleComment: "",
      isFixedHandleComment: "",
      isGoodPulldownHandleWallContrastComment: "",
      isMirrorComment: "",
      areClothesHooksComment: "",
      isWastebasketComment: "",
      isTowelDispenserComment: "",
      isHandDryerComment: "",
      washbasinLocationHeight: "",
      isSpaceUnderWashbasinForWheelchairComment: "",
      isLightSwitchComment: "",
      isGoodLitComment: "",
      comment: "",
    ),
  ),
  isAccessAccessibleForPwd: "",
  hasAdditionalPurpose: 0,
  isNeedAuthorization: "",
  isEntranceGraphicallyMarked: "",
  isMarked: "",
  isFreeSpace: "",
  isGoodFloorWallContrast: "",
  isSideManeuveringSpace: "",
  isPulldownHandle: "",
  isFixedHandle: "",
  isGoodPulldownHandleWallContrast: "",
  isMirror: "",
  areClothesHooks: "",
  toiletSeatHeight: 0,
  isWastebasket: "",
  isTowelDispenser: "",
  isHandDryer: "",
  isSpaceUnderWashbasinForWheelchair: "",
  isLightSwitch: "",
  isGoodLit: "",
  imagesIndices: IListConst([]),
  doorsIndices: IListConst([]),
);

const meta = Meta<AdaptedToiletDetailView>();

final $default = AdaptedToiletDetailViewStory(
  args: AdaptedToiletDetailViewArgs(adaptedToilet: Arg.fixed(mockAdaptedToilet)),
);
