import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "../../../../../l10n/app_localizations.dart";
import "../../../business/accessibility_comments_manager.dart";
import "../data/models/digital_guide_dressing_room.dart";

class DressingRoomAccessibilityCommentsManager extends AccessibilityCommentsManager {
  DressingRoomAccessibilityCommentsManager({required this.l10n, required this.dressingRoomResponse});

  final AppLocalizations l10n;
  final DigitalGuideDressingRoom dressingRoomResponse;

  @override
  IList<String> getCommentsListForBlind() {
    final DigitalGuideTranslationDressingRoom pl = dressingRoomResponse.translations.pl;

    return IList([
      "${l10n.corridor_typhlomap(dressingRoomResponse.isMarked.toLowerCase())} ${pl.isMarkedComment}",
      "${l10n.dressing_room_are_access_barriers(dressingRoomResponse.areAccessBarriers.toLowerCase())} ${pl.areAccessBarriersComment}",
      "${l10n.dressing_room_are_seats_available(dressingRoomResponse.areSeatsAvailable.toLowerCase())} ${pl.areSeatsAvailableComment}",
      "${l10n.corridor_dangerous_elements(dressingRoomResponse.isMovementSpace.toLowerCase())} ${pl.isMovementSpaceComment}",
    ]).where((item) => item.trim().isNotEmpty).toIList();
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
    final DigitalGuideTranslationDressingRoom pl = dressingRoomResponse.translations.pl;
    return IList([
      "${l10n.dressing_room_is_good_lit(dressingRoomResponse.isGoodLit.toLowerCase())} ${pl.isGoodLitComment}",
      "${l10n.dressing_room_is_visible_from_afar(dressingRoomResponse.isVisibleFromAfar.toLowerCase())} ${pl.isVisibleFromAfarComment}",
    ]).where((item) => item.trim().isNotEmpty).toIList();
  }

  @override
  IList<String> getCommentsListForMotorImpairment() {
    final DigitalGuideTranslationDressingRoom pl = dressingRoomResponse.translations.pl;
    return IList([
      "${l10n.dressing_room_are_seats_available(dressingRoomResponse.areSeatsAvailable.toLowerCase())} ${pl.areSeatsAvailableComment}",
      "${l10n.dressing_room_counter_is_space_under(dressingRoomResponse.isSpaceUnderCounter.toLowerCase())} ${pl.isSpaceUnderCounterComment}",
      "${l10n.dressing_room_counter_is_space_on(dressingRoomResponse.isSpaceOnCounter.toLowerCase())} ${pl.isSpaceOnCounterComment}",
    ]).where((item) => item.trim().isNotEmpty).toIList();
  }

  @override
  IList<String> getCommentsListForSensorySensitivity() {
    return const IList.empty();
  }
}
