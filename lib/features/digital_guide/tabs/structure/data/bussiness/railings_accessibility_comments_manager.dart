import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "../../../../../../l10n/app_localizations.dart";
import "../../../../business/accessibility_comments_manager.dart";
import "../models/railing.dart";

class RailingsAccessibilityCommentsManager
    extends AccessibilityCommentsManager {
  RailingsAccessibilityCommentsManager({
    required this.railing,
    required this.l10n,
  });

  final Railing railing;
  final AppLocalizations l10n;

  @override
  IList<String> getCommentsListForBlind() {
    final RailingTranslation pl = railing.translations.plTranslation;

    return IList([
      "${l10n.railing_is_railing_on_landings(railing.isRailingOnLandings.toLowerCase())} ${pl.isRailingOnLandingsComment}",
      "${l10n.railing_is_two_sided_railing(railing.isTwoSidedRailing.toLowerCase())} ${pl.isTwoSidedRailingComment}",
      "${l10n.railing_is_braille_convex_marking(railing.isBrailleConvexMarking.toLowerCase())} ${pl.isBrailleConvexMarkingComment}",
      "${l10n.railing_is_round_cross_section_railing(railing.isRoundCrossSectionRailing.toLowerCase())} ${pl.isRoundCrossSectionRailingComment}",
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
    final RailingTranslation pl = railing.translations.plTranslation;
    return IList([
      "${l10n.railing_is_good_railing_contrast(railing.isGoodRailingContrast.toLowerCase())} ${pl.isGoodRailingContrastComment}",
      "${l10n.railing_is_railing_extended_30cm(railing.isRailingExtended30cm.toLowerCase())} ${pl.isRailingExtended30cmComment}",
    ]).where((item) => item.trim().isNotEmpty).toIList();
  }

  @override
  IList<String> getCommentsListForMotorImpairment() {
    final RailingTranslation pl = railing.translations.plTranslation;
    return IList([
      "${l10n.railing_is_railing_obstacle(railing.isRailingObstacle.toLowerCase())} ${pl.isRailingObstacleComment}",
    ]).where((item) => item.trim().isNotEmpty).toIList();
  }

  @override
  IList<String> getCommentsListForSensorySensitivity() {
    return const IList.empty();
  }
}
