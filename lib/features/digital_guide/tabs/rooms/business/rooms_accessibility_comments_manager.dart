import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "../../../../../l10n/app_localizations.dart";
import "../../../business/accessibility_comments_manager.dart";
import "../data/models/digital_guide_room.dart";

class RoomsAccessibilityCommentsManager extends AccessibilityCommentsManager {
  RoomsAccessibilityCommentsManager({
    required this.digitalGuideRoom,
    required this.l10n,
  });

  DigitalGuideRoom digitalGuideRoom;
  AppLocalizations l10n;

  @override
  IList<String> getCommentsListForBlind() {
    final comments = digitalGuideRoom.translations.pl;

    final IList<String> commentList = [
      "${l10n.rooms_is_one_level_floor(digitalGuideRoom.isOneLevelFloor.toLowerCase())} ${comments.isOneLevelFloorComment}",
      "${l10n.rooms_are_movable_elements(digitalGuideRoom.areMovableElements.toLowerCase())} ${comments.areMovableElementsComment}",
      "${l10n.rooms_is_generally_available_desk(digitalGuideRoom.isGenerallyAvailableDesk.toLowerCase())} ${comments.isGenerallyAvailableDeskComment}",
      "${l10n.rooms_are_any_dangerous_elements(digitalGuideRoom.areAnyDangerousElements.toLowerCase())} ${comments.areAnyDangerousElementsComment}",
    ].where((c) => c.trim().isNotEmpty).toIList();

    return commentList;
  }

  @override
  IList<String> getCommentsListForCognitiveImpairment() {
    final comments = digitalGuideRoom.translations.pl;

    final IList<String> commentList = [
      "${l10n.rooms_is_floor_shiny(digitalGuideRoom.isFloorShiny.toLowerCase())} ${comments.isFloorShinyComment}",
      "${l10n.rooms_are_flashing_devices(digitalGuideRoom.areFlashingDevices.toLowerCase())} ${comments.areFlashingDevicesComment}",
    ].where((c) => c.trim().isNotEmpty).toIList();

    return commentList;
  }

  @override
  IList<String> getCommentsListForHearingImpairment() {
    return const IList.empty();
  }

  @override
  IList<String> getCommentsListForSensorySensitivity() {
    final comments = digitalGuideRoom.translations.pl;

    final IList<String> commentList = [
      "${l10n.rooms_has_induction_loop(digitalGuideRoom.hasInductionLoop.toLowerCase())} ${comments.hasInductionLoopComment}",
      "${l10n.rooms_are_flashing_devices(digitalGuideRoom.areFlashingDevices.toLowerCase())} ${comments.areFlashingDevicesComment}",
    ].where((c) => c.trim().isNotEmpty).toIList();

    return commentList;
  }

  @override
  IList<String> getCommentsListForLowVision() {
    final comments = digitalGuideRoom.translations.pl;

    final IList<String> commentList = [
      "${l10n.rooms_is_one_level_floor(digitalGuideRoom.isOneLevelFloor.toLowerCase())} ${comments.isOneLevelFloorComment}",
      "${l10n.rooms_are_any_dangerous_elements(digitalGuideRoom.areAnyDangerousElements.toLowerCase())} ${comments.areAnyDangerousElementsComment}",
      "${l10n.rooms_is_good_floor_room_contrast(digitalGuideRoom.isGoodFloorRoomContrast.toLowerCase())} ${comments.isGoodFloorRoomContrastComment}",
      "${l10n.rooms_is_good_lit(digitalGuideRoom.isGoodLit.toLowerCase())} ${comments.isGoodLitComment}",
      "${l10n.rooms_is_floor_shiny(digitalGuideRoom.isFloorShiny.toLowerCase())} ${comments.isFloorShinyComment}",
      l10n.rooms_is_blackboard(
        comments.isBlackboardComment,
        digitalGuideRoom.isBlackboard.toLowerCase(),
      ),
    ].where((c) => c.trim().isNotEmpty).toIList();

    return commentList;
  }

  @override
  IList<String> getCommentsListForMotorImpairment() {
    final comments = digitalGuideRoom.translations.pl;

    final IList<String> commentList = [
      "${l10n.rooms_is_one_level_floor(digitalGuideRoom.isOneLevelFloor.toLowerCase())} ${comments.isOneLevelFloorComment}",
      "${l10n.rooms_are_places_for_wheelchairs(digitalGuideRoom.arePlacesForWheelchairs.toLowerCase())} ${comments.arePlacesForWheelchairsComment}",
      "${l10n.rooms_are_places_accessible_from_main_entrance(digitalGuideRoom.arePlacesAccessibleFromMainEntrance.toLowerCase())} ${comments.arePlacesAccessibleFromMainEntranceComment}",
      "${l10n.rooms_is_generally_available_desk(digitalGuideRoom.isGenerallyAvailableDesk.toLowerCase())} ${comments.isGenerallyAvailableDeskComment}",
      l10n.rooms_is_space_under_counter(
        digitalGuideRoom.isSpaceUnderCounter.toLowerCase(),
      ),
      "${l10n.rooms_are_movable_elements(digitalGuideRoom.areMovableElements.toLowerCase())} ${comments.areMovableElementsComment}",
      "${l10n.rooms_are_electrical_outlets(digitalGuideRoom.areElectricalOutlets.toLowerCase())} ${comments.areElectricalOutletsComment}",
    ].where((c) => c.trim().isNotEmpty).toIList();

    return commentList;
  }
}
