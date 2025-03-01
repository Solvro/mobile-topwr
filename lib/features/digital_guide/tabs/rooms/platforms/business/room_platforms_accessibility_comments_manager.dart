import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "../../../../../../l10n/app_localizations.dart";
import "../../../../business/accessibility_comments_manager.dart";
import "../models/room_platforms_response.dart";

class RoomPlatformsAccessibilityCommentsManager extends AccessibilityCommentsManager {
  RoomPlatformsAccessibilityCommentsManager({required this.roomPlatformsResponse, required this.l10n});

  final RoomPlatformsResponse roomPlatformsResponse;
  final AppLocalizations l10n;

  @override
  IList<String> getCommentsListForMotorImpairment() {
    final comments = roomPlatformsResponse.translations.pl;

    final IList<String> commentList =
        [
          "${l10n.platform_dimensions} ${comments.platformDimensions}",
          "${l10n.room_platforms_are_no_objects_narrow_communication_zone(roomPlatformsResponse.areNoObjectsNarrowCommunicationZone.toLowerCase())} ${comments.areNoObjectsNarrowCommunicationZoneComment}",
          "${l10n.room_platforms_have_access_for_people_in_wheelchair(roomPlatformsResponse.haveAccessForPeopleInWheelchair.toLowerCase())} ${comments.haveAccessForPeopleInWheelchairComment}",
          "${l10n.room_platforms_is_platform_entrance_marked(roomPlatformsResponse.isPlatformEntranceMarked.toLowerCase())} ${comments.isPlatformEntranceMarkedComment}",
        ].where((c) => c.trim().isNotEmpty).toIList();

    return commentList;
  }

  @override
  IList<String> getCommentsListForCognitiveImpairment() {
    return const IList.empty();
  }

  @override
  IList<String> getCommentsListForHearingImpairment() {
    return const IList.empty();
  }

  @override
  IList<String> getCommentsListForLowVision() {
    final comments = roomPlatformsResponse.translations.pl;

    final IList<String> commentList =
        [
          comments.areStepsLeadingToThePlatform,
          "${l10n.room_platforms_is_good_floor_platform_contrast(roomPlatformsResponse.isGoodFloorPlatformContrast.toLowerCase())} ${comments.isGoodFloorPlatformContrastComment}",
          "${l10n.room_platforms_is_platform_entrance_marked(roomPlatformsResponse.isPlatformEntranceMarked.toLowerCase())} ${comments.isPlatformEntranceMarkedComment}",
        ].where((c) => c.trim().isNotEmpty).toIList();

    return commentList;
  }

  @override
  IList<String> getCommentsListForBlind() {
    final comments = roomPlatformsResponse.translations.pl;

    final IList<String> commentList =
        [
          "${l10n.platform_dimensions} ${comments.platformDimensions}",
          comments.areStepsLeadingToThePlatform,
          "${l10n.room_platforms_is_platform_entrance_marked(roomPlatformsResponse.isPlatformEntranceMarked.toLowerCase())} ${comments.isPlatformEntranceMarkedComment}",
        ].where((c) => c.trim().isNotEmpty).toIList();

    return commentList;
  }

  @override
  IList<String> getCommentsListForSensorySensitivity() {
    return const IList.empty();
  }
}
