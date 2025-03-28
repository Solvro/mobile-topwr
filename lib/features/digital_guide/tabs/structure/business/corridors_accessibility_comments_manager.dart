import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "../../../../../l10n/app_localizations.dart";
import "../../../business/accessibility_comments_manager.dart";
import "../data/models/corridor.dart";

class CorridorsAccessibilityCommentsManager extends AccessibilityCommentsManager {
  CorridorsAccessibilityCommentsManager({required this.l10n, required this.corridor});

  final AppLocalizations l10n;
  final Corridor corridor;

  @override
  IList<String> getCommentsListForBlind() {
    final comments = corridor.translations.plTranslation;

    return IList([
      "${l10n.corridor_typhlomap(corridor.isTyphlomap.toLowerCase())} ${comments.isTyphlomapComment}",
      "${l10n.corridor_info_plates_accessible(corridor.arePlatesInfoAccessible.toLowerCase())} ${comments.arePlatesInfoAccessibleComment}",
      "${l10n.corridor_horizontal_markings_for_blind(corridor.areHorizontalMarkingsForBlind.toLowerCase())} ${comments.areHorizontalMarkingsForBlindComment}",
      "${l10n.corridor_dangerous_elements(corridor.areDangerousElements.toLowerCase())} ${comments.areDangerousElementsComment}",
    ]).toIList();
  }

  @override
  IList<String> getCommentsListForCognitiveImpairment() {
    final comments = corridor.translations.plTranslation;

    return IList([
      "${l10n.corridor_rooms_marked(corridor.areRoomsMarked.toLowerCase())} ${comments.areRoomsMarkedComment}",
      "${l10n.corridor_pictogram_used(corridor.arePictogramsUsed.toLowerCase())} ${comments.arePictogramsUsedComment}",
      "${l10n.corridor_is_glare(corridor.isGlare.toLowerCase())} ${comments.isGlareComment}",
      "${l10n.corridor_echo(corridor.isCorridorCausesEcho.toLowerCase())} ${comments.isCorridorCausesEchoComment}",
      "${l10n.corridor_flashing_device(corridor.areAnyFlashingDevices.toLowerCase())} ${comments.areAnyFlashingDevicesComment}",
    ]).toIList();
  }

  @override
  IList<String> getCommentsListForHearingImpairment() {
    return IList([
      "${l10n.corridor_echo(corridor.isCorridorCausesEcho.toLowerCase())} ${corridor.translations.plTranslation.isCorridorCausesEchoComment}",
    ]).toIList();
  }

  @override
  IList<String> getCommentsListForLowVision() {
    final comments = corridor.translations.plTranslation;

    return IList([
      "${l10n.corridor_plates_with_rooms_list_have_readable_font(corridor.arePlatesWithRoomsListHaveReadableFont.toLowerCase())} ${comments.arePlatesWithRoomsListHaveReadableFontComment}",
      "${l10n.corridor_typhlomap(corridor.isTyphlomap.toLowerCase())} ${comments.isTyphlomapComment}",
      "${l10n.corridor_rooms_marked(corridor.areRoomsMarked.toLowerCase())} ${comments.areRoomsMarkedComment}",
      "${l10n.corridor_info_plates_accessible(corridor.arePlatesInfoAccessible.toLowerCase())} ${comments.arePlatesInfoAccessibleComment}",
      "${l10n.corridor_pictogram_used(corridor.arePictogramsUsed.toLowerCase())} ${comments.arePictogramsUsedComment}",
      "${l10n.corridor_is_glare(corridor.isGlare.toLowerCase())} ${comments.isGlareComment}",
      "${l10n.corridor_good_walls_contrast(corridor.isGoodWallsColorContrast.toLowerCase())} ${comments.isGoodWallsColorContrastComment}",
      "${l10n.corridor_good_lit(corridor.isGoodLit.toLowerCase())} ${comments.isGoodLitComment}",
      "${l10n.corridor_horizontal_markings_for_visually_impaired(corridor.areHorizontalMarkingsForVisuallyImpaired.toLowerCase())} ${comments.areHorizontalMarkingsForVisuallyImpairedComment}",
    ]).toIList();
  }

  @override
  IList<String> getCommentsListForMotorImpairment() {
    final comments = corridor.translations.plTranslation;

    return IList([
      "${l10n.corridor_min_width_length(corridor.isEnoughMinWidthLength.toLowerCase())} ${comments.isEnoughMinWidthLengthComment}",
      "${l10n.corridor_railings(corridor.areRailings.toLowerCase())} ${comments.areRailingsComment}",
      "${l10n.corridor_light_switches_sockets_height(corridor.isCorrectLightSwitchesSocketsHeight.toLowerCase())} ${comments.isCorrectLightSwitchesSocketsHeightComment}",
      "${l10n.corridor_dangerous_elements(corridor.areDangerousElements.toLowerCase())} ${comments.areDangerousElementsComment}",
    ]).toIList();
  }

  @override
  IList<String> getCommentsListForSensorySensitivity() {
    return const IList.empty();
  }
}
