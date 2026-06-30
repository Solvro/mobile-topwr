import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/tabs/information_points/models/digital_guide_information_points.dart";
import "package:topwr/features/digital_guide/tabs/structure/presentation/views/information_point_view.dart";
import "package:widgetbook/widgetbook.dart";

part "information_point_view.stories.g.dart";

final _mockInformationPoint = DigitalGuideInformationPoint(
  id: 1,
  translations: DigitalGuideInformationPointTranslations(
    pl: DigitalGuideInformationPointTranslationDetails(
      location: "First floor, entrance A",
      isMarkedComment: "Clearly marked",
      isVisibleFromAfarComment: "Easily visible",
      areAccessBarriersComment: "No barriers",
      areSeatsAvailableComment: "Seats available",
      isMovementSpaceComment: "Spacious",
      isGoodLitComment: "Well-lit",
      isSpaceUnderCounterComment: "Space under counter",
      isSpaceOnCounterComment: "Space on counter",
      hasInductionLoopComment: "No induction loop",
      workingDaysAndHours: "Mon-Fri 8-16",
      comment: "Reception is friendly",
    ),
  ),
  orderNumber: 1,
  isMarked: "yes",
  isVisibleFromAfar: "yes",
  areAccessBarriers: "no",
  areSeatsAvailable: "yes",
  isMovementSpace: "yes",
  isGoodLit: "yes",
  counterHeight: 90,
  isSpaceUnderCounter: "yes",
  isSpaceOnCounter: "yes",
  hasInductionLoop: "no",
  hasSoundTransmitter: null,
  building: 1,
  rings: [],
  images: [],
);

const meta = Meta(InformationPointView.new);

final $default = InformationPointViewStory(
  args: InformationPointViewArgs(informationPoint: Arg.fixed(_mockInformationPoint)),
);
