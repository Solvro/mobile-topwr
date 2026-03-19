import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/data/models/level.dart";
import "package:topwr/features/digital_guide/tabs/rooms/presentation/digital_guide_room_level.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

const _mockLevel = Level(
  id: 1,
  floorNumber: 0,
  translations: LevelTranslations(
    plTranslation: LevelTranslation(name: "Ground Floor", roomNumbersRange: "100-150"),
  ),
  regionIndices: [1],
);

@widgetbook.UseCase(name: "default", type: DigitalGuideRoomLevel)
Widget useCaseDigitalGuideRoomLevel(BuildContext context) {
  return const DigitalGuideRoomLevel(level: _mockLevel, rooms: IList.empty());
}
