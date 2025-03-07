import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "../../../../../l10n/app_localizations.dart";
import "../../../business/accessibility_comments_manager.dart";
import "../data/models/digital_guide_entrace.dart";

class EntracesAccessibilityCommentsManager extends AccessibilityCommentsManager {
  EntracesAccessibilityCommentsManager({required this.digitalGuideEntrance, required this.l10n});

  final DigitalGuideEntrace digitalGuideEntrance;
  final AppLocalizations l10n;

  @override
  IList<String> getCommentsListForBlind() {
    final DigitalGuideTranslationEntrace pl = digitalGuideEntrance.translations.pl;

    return IList([
      "${l10n.entrance_is_building_marked_from_entrance(digitalGuideEntrance.isBuildingMarkedFromEntrance.toString().toLowerCase())} ${pl.isBuildingMarkedFromEntranceComment}",
      "${l10n.entrance_is_building_marked_in_en(digitalGuideEntrance.isBuildingMarkedInEn.toString().toLowerCase())} ${pl.isBuildingMarkedInEnComment}",
      "${l10n.entrance_has_tactile_paving(digitalGuideEntrance.hasTactilePaving.toString().toLowerCase())} ${pl.hasTactilePavingComment}",
      "${l10n.entrance_has_sound_transmitter(digitalGuideEntrance.hasSoundTransmitter.toString().toLowerCase())} ${pl.hasSoundTransmitterComment}",
    ]).where((item) => item.trim().isNotEmpty).toIList();
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

    return IList([
      "${l10n.entrance_is_lit(digitalGuideEntrance.isLit.toString().toLowerCase())} ${pl.isLitComment}",
    ]).where((item) => item.trim().isNotEmpty).toIList();
  }

  @override
  IList<String> getCommentsListForMotorImpairment() {
    final DigitalGuideTranslationEntrace pl = digitalGuideEntrance.translations.pl;

    return IList([
      "${l10n.entrance_is_accessible(digitalGuideEntrance.isAccessible.toString().toLowerCase())} ${pl.comment}",
      l10n.entrance_number_of_doors(digitalGuideEntrance.numberOfDoors),
      if (digitalGuideEntrance.doorsDistance.isNotEmpty)
        l10n.entrance_doors_distance(digitalGuideEntrance.doorsDistance),
      "${l10n.entrance_are_benches(digitalGuideEntrance.areBenches.toString().toLowerCase())} ${pl.areBenchesComment}",
      "${l10n.entrance_is_protection_from_weather(digitalGuideEntrance.isProtectionFromWeather.toString().toLowerCase())} ${pl.isProtectionFromWeatherComment}",
      "${l10n.entrance_is_solid_surface(digitalGuideEntrance.isSolidSurface.toString().toLowerCase())} ${pl.isSolidSurfaceComment}",
      "${l10n.entrance_are_different_types_of_surface(digitalGuideEntrance.areDifferentTypesOfSurface.toString().toLowerCase())} ${pl.areDifferentTypesOfSurfaceComment}",
    ]).where((item) => item.trim().isNotEmpty).toIList();
  }
}
