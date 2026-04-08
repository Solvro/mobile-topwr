import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:topwr/features/digital_guide/tabs/structure/data/models/corridor.dart";
import "package:topwr/features/digital_guide/tabs/structure/presentation/views/corridor_view.dart";
import "package:widgetbook/widgetbook.dart";

part "corridor_view.stories.g.dart";

final _mockCorridor = Corridor(
  translations: const CorridorTranslations(
    plTranslation: CorridorTranslation(
      name: "Mock Corridor",
      isSimpleCorridorLayoutComment: "Layout comment",
      isFloorMarkedComment: "Floor marked comment",
      areRoomsEntrancesComment: "Entrances comment",
      isInformationBoardComment: "Info board comment",
      areRoomPurposeDescribedInEnComment: "Purpose desc EN comment",
      isConsistentLevelColorPatternComment: "Color pattern comment",
      arePictorialDirectionalSignsComment: "Directional signs comment",
      areSeatsComment: "Seats comment",
      areVendingMachinesComment: "Vending machines comment",
      vendingMachinesProducts: "Drinks, Snacks",
      isEmergencyPlanComment: "Emergency plan comment",
      isTyphlomapComment: "Typhlomap comment",
      areDangerousElementsComment: "Dangerous elements comment",
      arePlatesInfoAccessibleComment: "Info accessible comment",
      areHorizontalMarkingsForBlindComment: "Blind markings comment",
      arePlatesWithRoomsListHaveReadableFontComment: "Readable font comment",
      areRoomsMarkedComment: "Rooms marked comment",
      arePictogramsUsedComment: "Pictograms used comment",
      isGlareComment: "Glare comment",
      isGoodWallsColorContrastComment: "Good color contrast comment",
      isGoodLitComment: "Well lit comment",
      areHorizontalMarkingsForVisuallyImpairedComment: "Markings visually impaired comment",
      isEnoughMinWidthLengthComment: "Width length comment",
      areRailingsComment: "Railings comment",
      isCorrectLightSwitchesSocketsHeightComment: "Switches sockets height comment",
      isCorridorCausesEchoComment: "Echo comment",
      areAnyFlashingDevicesComment: "Flashing devices comment",
      comment: "General corridor comment",
    ),
  ),
  isSimpleCorridorLayout: "true",
  isFloorMarked: "false",
  areRoomsEntrances: "true",
  isInformationBoard: "true",
  areRoomPurposeDescribedInEn: "false",
  isConsistentLevelColorPattern: "true",
  arePictorialDirectionalSigns: "true",
  areSeats: "false",
  areVendingMachines: "true",
  isEmergencyPlan: "true",
  isTyphlomap: "false",
  areDangerousElements: "false",
  arePlatesInfoAccessible: "true",
  areHorizontalMarkingsForBlind: "false",
  arePlatesWithRoomsListHaveReadableFont: "true",
  areRoomsMarked: "true",
  arePictogramsUsed: "false",
  isGlare: "false",
  isGoodWallsColorContrast: "true",
  isGoodLit: "true",
  areHorizontalMarkingsForVisuallyImpaired: "false",
  isEnoughMinWidthLength: "true",
  areRailings: "true",
  isCorrectLightSwitchesSocketsHeight: "true",
  isCorridorCausesEcho: "false",
  areAnyFlashingDevices: "false",
  doorsIndices: IList(const [1, 2]),
  imagesIndices: IList(const [10, 11]),
);

const meta = Meta<CorridorView>();

final $default = CorridorViewStory(args: CorridorViewArgs(corridor: Arg.fixed(_mockCorridor)));
