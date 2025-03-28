import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "../../../../../l10n/app_localizations.dart";
import "../../../business/accessibility_comments_manager.dart";
import "../data/models/ramp.dart";

class RampsAccessibilityCommentsManager extends AccessibilityCommentsManager {
  RampsAccessibilityCommentsManager({required this.ramps, required this.l10n});

  final Ramp ramps;
  final AppLocalizations l10n;

  @override
  IList<String> getCommentsListForBlind() {
    final RampTranslation pl = ramps.translations.plTranslation;
    return IList([
      "${l10n.ramps_is_ramp_marked(ramps.isRampMarked.toLowerCase())} ${pl.isRampMarkedComment}",
    ]).toIList();
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
    final RampTranslation pl = ramps.translations.plTranslation;
    return IList([
      "${l10n.ramps_is_good_lit(ramps.isGoodLit.toLowerCase())} ${pl.isGoodLitComment}",
      "${l10n.ramps_is_ramp_marked(ramps.isRampMarked.toLowerCase())} ${pl.isRampMarkedComment}",
    ]).toIList();
  }

  @override
  IList<String> getCommentsListForMotorImpairment() {
    final RampTranslation pl = ramps.translations.plTranslation;
    return IList([
      "${l10n.ramps_are_nonslip_elements(ramps.areNonslipElements.toLowerCase())} ${pl.areNonslipElementsComment}",
      "${l10n.ramps_is_increased_force_needed(ramps.isIncreasedForceNeeded.toLowerCase())} ${pl.isIncreasedForceNeededComment}",
      if (pl.numberOfLandings.isNotEmpty) "${l10n.number_of_ramp_landings} ${pl.numberOfLandings}",
      if (pl.dimensionsOfTheLandings.isNotEmpty) "${l10n.dimensions_of_the_landings} ${pl.dimensionsOfTheLandings}",
    ]);
  }

  @override
  IList<String> getCommentsListForSensorySensitivity() {
    return const IList.empty();
  }
}
