import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/tabs/rooms/stairs/presentation/room_stairs_content.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: RoomStairsContent)
Widget useCaseRoomStairsContent(BuildContext context) {
  return const RoomStairsContent(roomStairsId: 1);
}
