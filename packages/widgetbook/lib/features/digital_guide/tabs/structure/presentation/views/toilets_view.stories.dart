import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:topwr/features/digital_guide/tabs/structure/data/models/toilet.dart";
import "package:topwr/features/digital_guide/tabs/structure/presentation/views/toilets_view.dart";
import "package:widgetbook/widgetbook.dart";

part "toilets_view.stories.g.dart";

final mockToilet = Toilet(
  translations: const ToiletTranslations(
    plTranslation: ToiletTranslation(
      location: "Ground floor, left wing",
      numberOfCabins: "3",
      toiletDescription: "Modern accessible restroom.",
      isNeedAuthorizationComment: "No special authorization required.",
      isWastebasketComment: "Wastebasket available.",
      areClothesHooksComment: "Multiple hooks available.",
      isHandDryerComment: "Hand dryer present.",
      isTowelDispenserComment: "Towel dispenser available.",
      isWashbasinComment: "Washbasin present in each cabin.",
      isSpaceUnderWashbasinForWheelchairComment: "Accessible for wheelchairs.",
      isLightSwitchComment: "Light switch at accessible height.",
      isGoodLitComment: "Well lit.",
      isGoodDevicesWallContrastComment: "High color contrast on devices/walls.",
      comment: "Spacious and maintained regularly.",
    ),
  ),
  toiletType: ToiletType.women,
  isNeedAuthorization: "no",
  isWastebasket: "yes",
  areClothesHooks: "yes",
  isHandDryer: "yes",
  isTowelDispenser: "yes",
  isWashbasin: "yes",
  isSpaceUnderWashbasinForWheelchair: "yes",
  isLightSwitch: "yes",
  isGoodLit: "yes",
  isGoodDevicesWallContrast: "yes",
  doorsIds: IList(const [101, 102]),
);

const meta = Meta(ToiletsView.new);

final $default = ToiletsViewStory(args: ToiletsViewArgs(toilet: Arg.fixed(mockToilet)));
