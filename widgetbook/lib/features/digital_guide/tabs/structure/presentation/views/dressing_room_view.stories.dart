import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/tabs/dressing_room/data/models/digital_guide_dressing_room.dart";
import "package:topwr/features/digital_guide/tabs/structure/presentation/views/dressing_room_view.dart";
import "package:widgetbook/widgetbook.dart";

part "dressing_room_view.stories.g.dart";

const _mockDressingRoom = DigitalGuideDressingRoom(
  id: 1,
  isMarked: "yes",
  isVisibleFromAfar: "yes",
  areAccessBarriers: "no",
  areSeatsAvailable: "yes",
  isMovementSpace: "yes",
  isGoodLit: "yes",
  counterHeight: 90,
  isSpaceUnderCounter: "yes",
  isSpaceOnCounter: "yes",
  translations: DigitalGuideTranslationsDressingRoom(
    pl: DigitalGuideTranslationDressingRoom(
      location: "Ground floor",
      workingDaysAndHours: "Mon–Fri",
      comment: "",
      isMarkedComment: "",
      isVisibleFromAfarComment: "",
      areAccessBarriersComment: "",
      areSeatsAvailableComment: "",
      isMovementSpaceComment: "",
      isGoodLitComment: "",
      isSpaceUnderCounterComment: "",
      isSpaceOnCounterComment: "",
    ),
  ),
  imagesIds: null,
);

const meta = Meta<DressingRoomView>();

final $default = DressingRoomViewStory(args: DressingRoomViewArgs(dressingRoom: Arg.fixed(_mockDressingRoom)));
