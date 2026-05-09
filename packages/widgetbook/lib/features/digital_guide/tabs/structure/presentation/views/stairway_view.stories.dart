import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:topwr/features/digital_guide/tabs/structure/data/models/stairway.dart";
import "package:topwr/features/digital_guide/tabs/structure/presentation/views/stairway_view.dart";
import "package:widgetbook/widgetbook.dart";

part "stairway_view.stories.g.dart";

const mockStairway = Stairway(
  translations: StairwayTranslations(
    plTranslation: StairwayTranslation(
      name: "Klatka schodowa C-13 od strony Odry",
      location: "Północna część budynku, przy głównym korytarzu",
      areObjectsNarrowCommunicationZoneComment: "Narrow communication zone comment.",
      areInformationBoardsComment: "Information boards comment.",
      areInformationBoardsInEnComment: "EN information boards comment.",
      areRoomEntrancesComment: "Room entrances comment.",
      areFloorMarkingsComment: "Floor markings comment.",
      isTyphlomapComment: "Typhlomap comment.",
      comment: "General stairway comment.",
    ),
  ),
  areObjectsNarrowCommunicationZone: "Yes",
  areInformationBoards: "Yes",
  areInformationBoardsInEn: "No",
  areRoomEntrances: "Yes",
  areFloorMarkings: "Yes",
  isTyphlomap: "No",
  doorsIds: IListConst([11, 12]),
  liftsIds: IListConst([21]),
  stairsIds: IListConst([1, 2]),
  imagesIds: IListConst([101, 102]),
);

const meta = Meta<StairwayView>();

final $default = StairwayViewStory(args: StairwayViewArgs(stairway: Arg.fixed(mockStairway)));
