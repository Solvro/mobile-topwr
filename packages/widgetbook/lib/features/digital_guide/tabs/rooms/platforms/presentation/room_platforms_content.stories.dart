import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:topwr/features/digital_guide/tabs/rooms/platforms/models/room_platforms_response.dart";
import "package:topwr/features/digital_guide/tabs/rooms/platforms/presentation/room_platforms_content.dart";
import "package:topwr/features/digital_guide/tabs/rooms/platforms/repository/room_platforms_repository.dart";
import "package:widgetbook/widgetbook.dart";

part "room_platforms_content.stories.g.dart";

const meta = Meta<RoomPlatformsContent>();

const _mockRoomPlatform = RoomPlatformsResponse(
  id: 1,
  translations: RoomPlatformsTranslations(
    pl: RoomPlatformsTranslation(
      location: "First floor near room 1.27",
      platformDimensions: "180x140 cm",
      areStepsLeadingToThePlatform: "No",
      comment: "Platform is flat and clear.",
      isGoodFloorPlatformContrastComment: "Good contrast with corridor tiles.",
      haveAccessForPeopleInWheelchairComment: "Full wheelchair access.",
      isPlatformEntranceMarkedComment: "Entrance marked with signs.",
      areNoObjectsNarrowCommunicationZoneComment: "No obstacles in approach path.",
    ),
  ),
  isGoodFloorPlatformContrast: "yes",
  haveAccessForPeopleInWheelchair: "yes",
  isPlatformEntranceMarked: "yes",
  areNoObjectsNarrowCommunicationZone: "yes",
);

final $default = RoomPlatformsContentStory(
  setup: (context, child, args) => ProviderScope(
    key: ValueKey("room_platforms_content_story_${args.platformId}"),
    overrides: [roomPlatformsRepositoryProvider(args.platformId).overrideWith((ref) async => _mockRoomPlatform)],
    child: child,
  ),
  args: RoomPlatformsContentArgs.fixed(platformId: 1),
);
