import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "../../../../../l10n/app_localizations.dart";
import "../../../business/accessibility_comments_manager.dart";
import "../data/models/corridor.dart";

class CorridorsAccessibilityCommentsManager extends AccessibilityCommentsManager {
  CorridorsAccessibilityCommentsManager({
    required this.l10n,
    required this.corridor,
  });

  final AppLocalizations l10n;
  final Corridor corridor;

  @override
  IList<String> getCommentsListForBlind() {
    final comments = corridor.translations.plTranslation;

    return IList([
      "${l10n.corridor_typhlomap(corridor.isTyphlomap.toLowerCase())} ${comments.isTyphlomapComment}",
      "${l10n.corridor_info_plates_accessible(corridor.arePlatesInfoAccessible.toLowerCase())} ${comments.arePlatesInfoAccessibleComment}",
      "${l10n.horizontal_markings_for_blind(corridor.areHorizontalMarkingsForBlind.toLowerCase())} ${comments.areHorizontalMarkingsForBlindComment}",
      "${l10n.corridor_dangerous_elements(corridor.areDangerousElements.toLowerCase())} ${comments.areDangerousElementsComment}",
    ]).map((element) => element.trim()).where((element) => element.isNotEmpty).toIList();
  }

  @override
  IList<String> getCommentsListForCognitiveImpairment() {
    return IList([
      
    ]);
  }

  @override
  IList<String> getCommentsListForHearingImpairment() {
    return IList([
      
    ]);
  }

  @override
  IList<String> getCommentsListForLowVision() {
    return IList([
      
    ]);
  }

  @override
  IList<String> getCommentsListForMotorImpairment() {
    return IList([
      
    ]);
  }

  @override
  IList<String> getCommentsListForSensorySensitivity() {
    return IList([
      
    ]);
  }

}
