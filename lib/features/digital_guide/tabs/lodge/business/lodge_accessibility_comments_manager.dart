import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "../../../../../l10n/app_localizations.dart";
import "../../../business/accessibility_comments_manager.dart";
import "../data/models/digital_guide_lodge.dart";

class LodgeAccessibilityCommentsManager extends AccessibilityCommentsManager {
  LodgeAccessibilityCommentsManager({required this.l10n, required this.lodge});

  final AppLocalizations l10n;
  final DigitalGuideLodge lodge;

  @override
  IList<String> getCommentsListForBlind() {
    final comments = lodge.translations.pl;

    return IList([
      "${l10n.lodge_access_barriers(lodge.areAccessBarriers.toLowerCase())} ${comments.areAccessBarriersComment}",
      if (lodge.counterHeight > 0) l10n.lodge_counter_height(lodge.counterHeight),
    ]).map((element) => element.trim()).where((element) => element.isNotEmpty).toIList();
  }

  @override
  IList<String> getCommentsListForCognitiveImpairment() {
    return IList<String>(const []);
  }

  @override
  IList<String> getCommentsListForHearingImpairment() {
    return IList<String>(const []);
  }

  @override
  IList<String> getCommentsListForLowVision() {
    final comments = lodge.translations.pl;

    return IList([
      "${l10n.lodge_visible_from_afar(lodge.isVisibleFromAfar.toLowerCase())} ${comments.isVisibleFromAfarComment}",
      "${l10n.lodge_good_lit(lodge.isGoodLit.toLowerCase())} ${comments.isGoodLitComment}",
    ]).map((element) => element.trim()).where((element) => element.isNotEmpty).toIList();
  }

  @override
  IList<String> getCommentsListForMotorImpairment() {
    final comments = lodge.translations.pl;

    return IList([
      "${l10n.lodge_access_barriers(lodge.areAccessBarriers.toLowerCase())} ${comments.areAccessBarriersComment}",
      "${l10n.lodge_movement_space(lodge.isMovementSpace.toLowerCase())} ${comments.isMovementSpaceComment}",
      if (lodge.counterHeight > 0) l10n.lodge_counter_height(lodge.counterHeight),
      "${l10n.lodge_space_under_counter(lodge.isSpaceUnderCounter.toLowerCase())} ${comments.isSpaceUnderCounterComment}",
    ]).map((element) => element.trim()).where((element) => element.isNotEmpty).toIList();
  }

  @override
  IList<String> getCommentsListForSensorySensitivity() {
    return IList<String>(const []);
  }
}
