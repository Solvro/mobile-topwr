import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/tabs/dressing_room/data/models/digital_guide_dressing_room.dart";
import "package:topwr/features/digital_guide/tabs/structure/presentation/views/dressing_room_view.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: DressingRoomView)
Widget useCaseDressingRoomView(BuildContext context) {
  return const DressingRoomView(
    dressingRoom: DigitalGuideDressingRoom(
      id: 1,
      isMarked: "yes",
      isVisibleFromAfar: "yes",
      areAccessBarriers: "no",
      areSeatsAvailable: "yes",
      isMovementSpace: "yes",
      isGoodLit: "no",
      counterHeight: 90,
      isSpaceUnderCounter: "yes",
      isSpaceOnCounter: "no",
      translations: DigitalGuideTranslationsDressingRoom(
        pl: DigitalGuideTranslationDressingRoom(
          location: "Sample dressing room location",
          workingDaysAndHours: "Mon-Fri 9am-5pm",
          comment: "General comment about the dressing room.",
          isMarkedComment: "Marked for accessibility.",
          isVisibleFromAfarComment: "Visible from a distance.",
          areAccessBarriersComment: "No access barriers present.",
          areSeatsAvailableComment: "Seats are available inside.",
          isMovementSpaceComment: "There is enough space to move.",
          isGoodLitComment: "Lighting could be improved.",
          isSpaceUnderCounterComment: "Space under the counter is sufficient.",
          isSpaceOnCounterComment: "Some space on the counter is available.",
        ),
      ),
      imagesIds: [101, 102],
    ),
  );
}
