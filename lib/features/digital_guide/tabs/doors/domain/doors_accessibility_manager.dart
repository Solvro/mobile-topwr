import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "../../../../../l10n/app_localizations.dart";
import "../../../../../utils/type_converter.dart";
import "../../../business/accessibility_comments_manager.dart";
import "../data/model/door.dart";

class DoorsAccessibilityManager extends AccessibilityCommentsManager {
  DoorsAccessibilityManager({required this.l10n, required this.door});

  final AppLocalizations l10n;
  final Door door;

  @override
  IList<String> getCommentsListForBlind() {
    final pl = door.translations.pl;

    return IList([
      l10n.is_graphic(door.isGraphic.toLowerCase()),
      l10n.lift_width_text(door.doorWidth),
      if (pl.handleHeight.isNotEmpty) l10n.handle_heigth_text(pl.handleHeight),
      l10n.is_same_opening_system(door.isSameOpeningSystem.toLowerCase()),
      l10n.is_elevated_threshold(door.isElevatedThreshold.toLowerCase()) +
          l10n.elevated_threshold_text +
          pl.isElevatedThresholdComment,
    ]);
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
    return IList([l10n.are_glazed(door.areGlazed.toLowerCase()), l10n.are_visible(door.areVisible.toLowerCase())]);
  }

  @override
  IList<String> getCommentsListForMotorImpairment() {
    return IList([
      l10n.lift_width_text(door.doorWidth),
      l10n.is_elevated_threshold(door.isElevatedThreshold.toLowerCase()) + _elevated(),
    ]);
  }

  String _elevated() {
    if (stringToBool(door.isElevatedThreshold)) {
      final pl = door.translations.pl;

      return l10n.elevated_threshold_text + pl.isElevatedThresholdComment;
    }

    return "";
  }

  @override
  IList<String> getCommentsListForSensorySensitivity() {
    return const IList.empty();
  }
}
