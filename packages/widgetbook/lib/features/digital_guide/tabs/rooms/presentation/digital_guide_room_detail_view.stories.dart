import "package:topwr/features/digital_guide/tabs/rooms/data/models/digital_guide_room.dart";
import "package:topwr/features/digital_guide/tabs/rooms/presentation/digital_guide_room_detail_view.dart";
import "package:widgetbook/widgetbook.dart";
import "../../../../../widgetbook_mocks.dart";

part "digital_guide_room_detail_view.stories.g.dart";

const meta = Meta<DigitalGuideRoomDetailView>();

final $default = DigitalGuideRoomDetailViewStory(
  args: DigitalGuideRoomDetailViewArgs(room: Arg.fixed(mockDigitalGuideRoom)),
);
