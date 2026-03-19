import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/tabs/rooms/platforms/presentation/room_platforms_content.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: RoomPlatformsContent)
Widget useCaseRoomPlatformsContent(BuildContext context) {
  return const RoomPlatformsContent(platformId: 1);
}
