import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "../../../../../l10n/app_localizations.dart";
import "../../../business/accessibility_comments_manager.dart";
import "../data/models/toilet.dart";

class ToiletsAccessibilityCommentsManager extends AccessibilityCommentsManager {
  ToiletsAccessibilityCommentsManager({required this.toilet, required this.l10n});

  final Toilet toilet;
  final AppLocalizations l10n;

  @override
  IList<String> getCommentsListForBlind() {
    return const IList.empty();
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
    final ToiletTranslation pl = toilet.translations.plTranslation;
    return IList([
      "${l10n.toilet_is_good_devices_wall_contrast(toilet.isGoodDevicesWallContrast.toLowerCase())} ${pl.isGoodDevicesWallContrastComment}",
      "${l10n.toilet_is_light_switch(toilet.isLightSwitch.toLowerCase())} ${pl.isLightSwitchComment}",
      "${l10n.toilet_is_good_lit(toilet.isGoodLit.toLowerCase())} ${pl.isGoodLitComment}",
    ]).toIList();
  }

  @override
  IList<String> getCommentsListForMotorImpairment() {
    final ToiletTranslation pl = toilet.translations.plTranslation;
    return IList([
      "${l10n.toilet_is_space_under_washbasin_for_wheelchair(toilet.isSpaceUnderWashbasinForWheelchair.toLowerCase())} ${pl.isSpaceUnderWashbasinForWheelchairComment}",
    ]).toIList();
  }

  @override
  IList<String> getCommentsListForSensorySensitivity() {
    return const IList.empty();
  }
}
