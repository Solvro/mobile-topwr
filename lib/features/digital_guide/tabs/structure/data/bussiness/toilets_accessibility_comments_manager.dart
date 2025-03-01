import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "../../../../../../l10n/app_localizations.dart";
import "../../../../business/accessibility_comments_manager.dart";
import "../models/toilet.dart";

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
      "${l10n.toilet_isGoodDevicesWallContrast(toilet.isGoodDevicesWallContrast.toLowerCase())} ${pl.isGoodDevicesWallContrastComment}",
      "${l10n.toilet_isLightSwitch(toilet.isLightSwitch.toLowerCase())} ${pl.isLightSwitchComment}",
      "${l10n.toilet_isGoodLit(toilet.isGoodLit.toLowerCase())} ${pl.isGoodLitComment}",
      "${l10n.toilet_isGoodDevicesWallContrast(toilet.isGoodDevicesWallContrast.toLowerCase())} ${pl.isGoodDevicesWallContrastComment}",
    ]).where((item) => item.trim().isNotEmpty).toIList();
  }

  @override
  IList<String> getCommentsListForMotorImpairment() {
    final ToiletTranslation pl = toilet.translations.plTranslation;
    return IList([
      "${l10n.toilet_isSpaceUnderWashbasinForWheelChair(toilet.isSpaceUnderWashbasinForWheelchair.toLowerCase())} ${pl.isSpaceUnderWashbasinForWheelchairComment}",
    ]).where((item) => item.trim().isNotEmpty).toIList();
  }

  @override
  IList<String> getCommentsListForSensorySensitivity() {
    return const IList.empty();
  }
}
