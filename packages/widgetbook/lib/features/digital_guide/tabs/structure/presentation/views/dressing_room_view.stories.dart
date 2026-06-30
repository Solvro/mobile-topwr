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
      comment: "Punkt znajduje się przy wejściu od strony dziedzińca.",
      isMarkedComment: "Stanowisko oznaczone tablicą kierunkową.",
      isVisibleFromAfarComment: "Lada widoczna z głównego korytarza.",
      areAccessBarriersComment: "Brak barier na dojściu i przy stanowisku.",
      areSeatsAvailableComment: "Przy stanowisku dostępne miejsca siedzące.",
      isMovementSpaceComment: "Przestrzeń manewrowa pozwala na swobodny obrót wózkiem.",
      isGoodLitComment: "Strefa jest równomiernie oświetlona.",
      isSpaceUnderCounterComment: "Pod blatem pozostawiono wolną przestrzeń.",
      isSpaceOnCounterComment: "Na blacie dostępna jest przestrzeń do odłożenia dokumentów.",
    ),
  ),
  imagesIds: [6, 7],
);

const meta = Meta(DressingRoomView.new);

final $default = DressingRoomViewStory(args: DressingRoomViewArgs(dressingRoom: Arg.fixed(_mockDressingRoom)));
