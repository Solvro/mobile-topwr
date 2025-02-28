import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "../../../../../../utils/context_extensions.dart";

import "models/room_platforms_response.dart";

extension RoomPlatformsCommentListX on BuildContext {
  IList<String> getRoomPlatformsCommentsList(RoomPlatformsResponse roomPlatformsResponse) {
    final roomInformation = roomPlatformsResponse.translations.pl;
    final IList<String> commentList =
        [
          roomInformation.location,
          roomInformation.areStepsLeadingToThePlatform,
          "${localize.platform_dimensions} ${roomInformation.platformDimensions}",
          roomInformation.comment,
        ].lock;

    return commentList;
  }

  IList<String> getRoomPlatformsAccessibilityCommentsList(RoomPlatformsResponse roomPlatformsResponse) {
    final comments = roomPlatformsResponse.translations.pl;

    final IList<String> commentList =
        [
          "${localize.room_platforms_is_good_floor_platform_contrast(roomPlatformsResponse.isGoodFloorPlatformContrast.toLowerCase())} ${comments.isGoodFloorPlatformContrastComment}",
          "${localize.room_platforms_are_no_objects_narrow_communication_zone(roomPlatformsResponse.areNoObjectsNarrowCommunicationZone)} ${comments.areNoObjectsNarrowCommunicationZoneComment}",
          "${localize.room_platforms_have_access_for_people_in_wheelchair(roomPlatformsResponse.haveAccessForPeopleInWheelchair)} ${comments.haveAccessForPeopleInWheelchairComment}",
          "${localize.room_platforms_is_platform_entrance_marked(roomPlatformsResponse.isPlatformEntranceMarked)} ${comments.isPlatformEntranceMarkedComment}",
        ].where((c) => c.trim().isNotEmpty).toIList();

    return commentList;
  }
}
