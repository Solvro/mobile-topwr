import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "../../../../../l10n/app_localizations.dart";
import "../../../business/accessibility_comments_manager.dart";
import "../data/models/stairway.dart";

class StairwayAccessibilityCommentsManager extends AccessibilityCommentsManager {
  StairwayAccessibilityCommentsManager({required this.stairway, required this.l10n});

  final Stairway stairway;
  final AppLocalizations l10n;

  @override
  IList<String> getCommentsListForBlind() {
    final StairwayTranslation pl = stairway.translations.plTranslation;

    return IList([
      "${l10n.are_objects_narrow_communication_zone(stairway.areObjectsNarrowCommunicationZone.toLowerCase())} ${pl.areObjectsNarrowCommunicationZoneComment}",
      "${l10n.are_information_boards(stairway.areInformationBoards.toLowerCase())} ${pl.areInformationBoardsComment}",
      "${l10n.are_information_boards_in_en(stairway.areInformationBoardsInEn.toLowerCase())} ${pl.areInformationBoardsInEnComment}",
      "${l10n.are_room_entrances(stairway.areRoomEntrances.toLowerCase())} ${pl.areRoomEntrancesComment}",
      "${l10n.are_floor_markings(stairway.areFloorMarkings.toLowerCase())} ${pl.areFloorMarkingsComment}",
      "${l10n.is_typhlomap(stairway.isTyphlomap.toLowerCase())} ${pl.isTyphlomapComment}",
    ]).toIList();
  }

  @override
  IList<String> getCommentsListForCognitiveImpairment() {
    return const IList.empty();
  }

  @override
  IList<String> getCommentsListForHearingImpairment() {
    final StairwayTranslation pl = stairway.translations.plTranslation;
    return IList([
      "${l10n.are_information_boards(stairway.areInformationBoards.toLowerCase())} ${pl.areInformationBoardsComment}",
      "${l10n.are_information_boards_in_en(stairway.areInformationBoardsInEn.toLowerCase())} ${pl.areInformationBoardsInEnComment}",
      "${l10n.is_typhlomap(stairway.isTyphlomap.toLowerCase())} ${pl.isTyphlomapComment}",
    ]).toIList();
  }

  @override
  IList<String> getCommentsListForLowVision() {
    final StairwayTranslation pl = stairway.translations.plTranslation;
    return IList([
      "${l10n.are_information_boards(stairway.areInformationBoards.toLowerCase())} ${pl.areInformationBoardsComment}",
      "${l10n.are_information_boards_in_en(stairway.areInformationBoardsInEn.toLowerCase())} ${pl.areInformationBoardsInEnComment}",
      "${l10n.are_room_entrances(stairway.areRoomEntrances.toLowerCase())} ${pl.areRoomEntrancesComment}",
      "${l10n.is_typhlomap(stairway.isTyphlomap.toLowerCase())} ${pl.isTyphlomapComment}",
    ]).toIList();
  }

  @override
  IList<String> getCommentsListForMotorImpairment() {
    final StairwayTranslation pl = stairway.translations.plTranslation;
    return IList([
      "${l10n.are_objects_narrow_communication_zone(stairway.areObjectsNarrowCommunicationZone.toLowerCase())} ${pl.areObjectsNarrowCommunicationZoneComment}",
      "${l10n.are_room_entrances(stairway.areRoomEntrances.toLowerCase())} ${pl.areRoomEntrancesComment}",
      "${l10n.is_typhlomap(stairway.isTyphlomap.toLowerCase())} ${pl.isTyphlomapComment}",
    ]).toIList();
  }

  @override
  IList<String> getCommentsListForSensorySensitivity() {
    return const IList.empty();
  }
}
