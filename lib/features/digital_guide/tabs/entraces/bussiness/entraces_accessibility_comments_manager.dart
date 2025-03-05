import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "../../../../../l10n/app_localizations.dart";
import "../../../business/accessibility_comments_manager.dart";
import "../data/models/digital_guide_entrace.dart";

class EntracesAccessibilityCommentsManager extends AccessibilityCommentsManager {
  EntracesAccessibilityCommentsManager({required this.digitalGuideEntrace, required this.l10n});

  final DigitalGuideEntrace digitalGuideEntrace;
  final AppLocalizations l10n;

  @override
  IList<String> getCommentsListForBlind() {
    final DigitalGuideTranslationEntrace pl = digitalGuideEntrace.translations.pl;

    return IList([
      "${l10n.entrance_is_building_marked_from_entrance(digitalGuideEntrace.isBuildingMarkedFromEntrance.toString().toLowerCase())} ${pl.isBuildingMarkedFromEntranceComment}",
      "${l10n.entrance_is_building_marked_in_en(digitalGuideEntrace.isBuildingMarkedInEn.toString().toLowerCase())} ${pl.isBuildingMarkedInEnComment}",
      "${l10n.entrance_has_tactile_paving(digitalGuideEntrace.hasTactilePaving.toString().toLowerCase())} ${pl.hasTactilePavingComment}",
      "${l10n.entrance_has_sound_transmitter(digitalGuideEntrace.hasSoundTransmitter.toString().toLowerCase())} ${pl.hasSoundTransmitterComment}",
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
    final DigitalGuideTranslationEntrace pl = digitalGuideEntrace.translations.pl;

    return IList([
      "${l10n.entrance_is_lit(digitalGuideEntrace.isLit.toString().toLowerCase())} ${pl.isLitComment}",
    ]).where((item) => item.trim().isNotEmpty).toIList();
  }

  @override
  IList<String> getCommentsListForMotorImpairment() {
    final DigitalGuideTranslationEntrace pl = digitalGuideEntrace.translations.pl;

    return IList([
      "${l10n.entrance_is_accessible(digitalGuideEntrace.isAccessible.toString().toLowerCase())} ${pl.comment}",
      l10n.entrance_number_of_doors(digitalGuideEntrace.numberOfDoors),
      if (digitalGuideEntrace.doorsDistance.isNotEmpty) l10n.entrance_doors_distance(digitalGuideEntrace.doorsDistance),
      "${l10n.entrance_are_benches(digitalGuideEntrace.areBenches.toString().toLowerCase())} ${pl.areBenchesComment}",
      "${l10n.entrance_is_protection_from_weather(digitalGuideEntrace.isProtectionFromWeather.toString().toLowerCase())} ${pl.isProtectionFromWeatherComment}",
      "${l10n.entrance_is_solid_surface(digitalGuideEntrace.isSolidSurface.toString().toLowerCase())} ${pl.isSolidSurfaceComment}",
      "${l10n.entrance_are_different_types_of_surface(digitalGuideEntrace.areDifferentTypesOfSurface.toString().toLowerCase())} ${pl.areDifferentTypesOfSurfaceComment}",
    ]).where((item) => item.trim().isNotEmpty).toIList();
  }
}
