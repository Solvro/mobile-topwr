import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/data/models/level.dart";
import "package:topwr/features/digital_guide/tabs/rooms/data/models/digital_guide_room.dart";
import "package:topwr/features/digital_guide/tabs/rooms/presentation/digital_guide_room_level.dart";
import "package:widgetbook/widgetbook.dart";
import "../../../../../widgetbook_mocks.dart";

part "digital_guide_room_level.stories.g.dart";

const _mockLevel = Level(
  id: 1,
  floorNumber: 0,
  translations: LevelTranslations(
    plTranslation: LevelTranslation(name: "Ground Floor", roomNumbersRange: "100-150"),
  ),
  regionIndices: [1],
);

const meta = Meta<DigitalGuideRoomLevel>();

final $default = DigitalGuideRoomLevelStory(
  args: DigitalGuideRoomLevelArgs(level: Arg.fixed(_mockLevel), rooms: Arg.fixed(IList(const [mockDigitalGuideRoom]))),
);
