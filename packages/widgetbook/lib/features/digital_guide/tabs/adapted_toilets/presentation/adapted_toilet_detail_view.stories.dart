import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:topwr/features/digital_guide/tabs/adapted_toilets/data/models/adapted_toilet.dart";
import "package:topwr/features/digital_guide/tabs/adapted_toilets/presentation/adapted_toilet_detail_view.dart";
import "package:widgetbook/widgetbook.dart";

part "adapted_toilet_detail_view.stories.g.dart";

const mockAdaptedToilet = AdaptedToilet(
  translations: AdaptedToiletTranslations(
    plTranslation: AdaptedToiletTranslation(
      location: "Parter, przy wejściu od strony wybrzeża Wyspiańskiego",
      toiletDescription: "Toaleta dostosowana z szerokim wejściem i uchwytami przy misce.",
      numberOfCabins: "1",
      isAccessAccessibleForPwdComment: "Dojście bez progów i z odpowiednią szerokością przejścia.",
      isNeedAuthorizationComment: "Pomieszczenie dostępne w godzinach pracy budynku.",
      isAreaAllowingMovementInFrontEntranceComment: "Przed wejściem zapewniono przestrzeń manewrową.",
      isEntranceGraphicallyMarkedComment: "Wejście oznaczone piktogramem.",
      isMarkedComment: "Drzwi oznaczone kontrastowo.",
      toiletDimensions: "220 x 190 cm",
      isFreeSpaceComment: "Zapewniona przestrzeń do obrotu wózkiem.",
      isGoodFloorWallContrastComment: "Kontrast podłogi i ścian jest wystarczający.",
      isSideManeuveringSpaceComment: "Po stronie miski dostępna przestrzeń transferowa.",
      isPulldownHandleComment: "Uchwyt opuszczany po lewej stronie.",
      isFixedHandleComment: "Uchwyt stały po prawej stronie.",
      isGoodPulldownHandleWallContrastComment: "Uchwyty odcinają się kolorystycznie od tła.",
      isMirrorComment: "Lustro obniżone i pochylone.",
      areClothesHooksComment: "Wieszaki dostępne na dwóch wysokościach.",
      isWastebasketComment: "Kosz ustawiony poza strefą manewrową.",
      isTowelDispenserComment: "Podajnik ręczników na wysokości dostępnej z pozycji siedzącej.",
      isHandDryerComment: "Suszarka ręczna zamontowana przy umywalce.",
      washbasinLocationHeight: "80 cm",
      isSpaceUnderWashbasinForWheelchairComment: "Pod umywalką pozostawiono wolną przestrzeń.",
      isLightSwitchComment: "Włącznik światła na wysokości dostępnej dla użytkowników wózków.",
      isGoodLitComment: "Równomierne oświetlenie bez silnych cieni.",
      comment: "Toaleta znajduje się blisko głównego ciągu komunikacyjnego.",
    ),
  ),
  isAccessAccessibleForPwd: "yes",
  hasAdditionalPurpose: 0,
  isNeedAuthorization: "no",
  isEntranceGraphicallyMarked: "yes",
  isMarked: "yes",
  isFreeSpace: "yes",
  isGoodFloorWallContrast: "yes",
  isSideManeuveringSpace: "yes",
  isPulldownHandle: "yes",
  isFixedHandle: "yes",
  isGoodPulldownHandleWallContrast: "yes",
  isMirror: "yes",
  areClothesHooks: "yes",
  toiletSeatHeight: 0,
  isWastebasket: "yes",
  isTowelDispenser: "yes",
  isHandDryer: "yes",
  isSpaceUnderWashbasinForWheelchair: "yes",
  isLightSwitch: "yes",
  isGoodLit: "yes",
  imagesIndices: IListConst([12, 13]),
  doorsIndices: IListConst([4]),
);

const meta = Meta(AdaptedToiletDetailView.new);

final $default = AdaptedToiletDetailViewStory(
  args: AdaptedToiletDetailViewArgs(adaptedToilet: Arg.fixed(mockAdaptedToilet)),
);
