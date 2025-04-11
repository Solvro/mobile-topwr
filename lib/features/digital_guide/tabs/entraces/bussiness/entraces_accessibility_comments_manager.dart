import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "../../../../../l10n/app_localizations.dart";
import "../../../business/accessibility_comments_manager.dart";
import "../data/models/digital_guide_entrace.dart";

class EntrancesAccessibilityCommentsManager extends AccessibilityCommentsManager {
  EntrancesAccessibilityCommentsManager({required this.digitalGuideEntrance, required this.l10n});

  final DigitalGuideEntrace digitalGuideEntrance;
  final AppLocalizations l10n;

  @override
  IList<String> getCommentsListForBlind() {
    final DigitalGuideTranslationEntrace pl = digitalGuideEntrance.translations.pl;

    return IList([
      "${l10n.entrance_is_building_marked_from_entrance(digitalGuideEntrance.isBuildingMarkedFromEntrance.toLowerCase())} ${pl.isBuildingMarkedFromEntranceComment}",
      "${l10n.entrance_is_building_marked_in_en(digitalGuideEntrance.isBuildingMarkedInEn.toLowerCase())} ${pl.isBuildingMarkedInEnComment}",
      "${l10n.entrance_has_tactile_paving(digitalGuideEntrance.hasTactilePaving.toLowerCase())} ${pl.hasTactilePavingComment}",
      "${l10n.entrance_has_sound_transmitter(digitalGuideEntrance.hasSoundTransmitter?.toLowerCase() ?? "false")} ${pl.hasSoundTransmitterComment}",
    ]).toIList();
  }

  @override
  IList<String> getCommentsListForCognitiveImpairment() => const IList.empty();

  @override
  IList<String> getCommentsListForHearingImpairment() => const IList.empty();

  @override
  IList<String> getCommentsListForSensorySensitivity() => const IList.empty();

  @override
  IList<String> getCommentsListForLowVision() {
    final DigitalGuideTranslationEntrace pl = digitalGuideEntrance.translations.pl;

    return IList(["${l10n.entrance_is_lit(digitalGuideEntrance.isLit.toLowerCase())} ${pl.isLitComment}"]).toIList();
  }

  @override
  IList<String> getCommentsListForMotorImpairment() {
    final DigitalGuideTranslationEntrace pl = digitalGuideEntrance.translations.pl;

    return IList([
      if (digitalGuideEntrance.doorsDistance.isNotEmpty)
        l10n.entrance_doors_distance(double.tryParse(digitalGuideEntrance.doorsDistance) ?? 0),
      "${l10n.entrance_are_benches(digitalGuideEntrance.areBenches.toLowerCase())} ${pl.areBenchesComment}",
      "${l10n.entrance_is_solid_surface(digitalGuideEntrance.isSolidSurface.toLowerCase())} ${pl.isSolidSurfaceComment}",
      "${l10n.entrance_are_different_types_of_surface(digitalGuideEntrance.areDifferentTypesOfSurface.toLowerCase())} ${pl.areDifferentTypesOfSurfaceComment}",
    ]).toIList();
  }
}
