import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/tabs/information_points/models/digital_guide_information_points.dart";
import "package:topwr/features/digital_guide/tabs/structure/presentation/views/information_point_view.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: InformationPointView)
Widget useCaseInformationPointView(BuildContext context) {
  // Mock translation details
  final translations = DigitalGuideInformationPointTranslations(
    pl: DigitalGuideInformationPointTranslationDetails(
      location: "Mock location",
      isMarkedComment: "Clear signage present",
      isVisibleFromAfarComment: "Visible from a distance",
      areAccessBarriersComment: "No access barriers",
      areSeatsAvailableComment: "Seats available",
      isMovementSpaceComment: "Sufficient movement space",
      isGoodLitComment: "Well lit area",
      isSpaceUnderCounterComment: "Space under counter available",
      isSpaceOnCounterComment: "Space on counter available",
      hasInductionLoopComment: "No induction loop",
      workingDaysAndHours: "Mon-Fri 08:00-16:00",
      comment: "General comment here",
    ),
  );

  // Mock DigitalGuideInformationPoint
  final mockInformationPoint = DigitalGuideInformationPoint(
    id: 1,
    translations: translations,
    orderNumber: 1,
    isMarked: "YES",
    isVisibleFromAfar: "YES",
    areAccessBarriers: "NO",
    areSeatsAvailable: "YES",
    isMovementSpace: "YES",
    isGoodLit: "YES",
    counterHeight: 90,
    isSpaceUnderCounter: "YES",
    isSpaceOnCounter: "YES",
    hasInductionLoop: "NO",
    hasSoundTransmitter: null,
    building: 1,
    rings: [],
    images: [],
  );

  return InformationPointView(informationPoint: mockInformationPoint);
}
