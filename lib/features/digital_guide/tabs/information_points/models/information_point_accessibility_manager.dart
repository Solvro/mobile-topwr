import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "../../../../../l10n/app_localizations.dart";
import "../../../business/accessibility_comments_manager.dart";
import "digital_guide_information_points.dart";

class InformationPointAccessibilityManager
    extends AccessibilityCommentsManager {
  InformationPointAccessibilityManager({
    required this.l10n,
    required this.infoPoint,
  });

  final AppLocalizations l10n;
  final DigitalGuideInformationPoint infoPoint;

  @override
  IList<String> getCommentsListForBlind() {
    return IList([
      if (infoPoint.areAccessBarriers) l10n.are_access_bariers,
      l10n.counter_heigth_text(infoPoint.counterHeight),
    ]);
  }

  @override
  IList<String> getCommentsListForCognitiveImpairment() {
    return const IList.empty();
  }

  @override
  IList<String> getCommentsListForHearingImpairment() {
    return IList([
      l10n.has_sound_transmitter(
          infoPoint.hasSoundTransmitter.toString().toLowerCase(),),
    ]);
  }

  @override
  IList<String> getCommentsListForLowVision() {
    return IList([
      l10n.is_good_lit_info_point(infoPoint.isGoodLit.toString().toLowerCase()),
      l10n.is_visible_from_afar(
          infoPoint.isVisibleFromAfar.toString().toLowerCase(),),
    ]);
  }

  @override
  IList<String> getCommentsListForMotorImpairment() {
    return IList([
      if (infoPoint.areAccessBarriers) l10n.are_access_bariers,
      l10n.is_movement_space(
        infoPoint.isMovementSpace.toString().toLowerCase(),
      ),
      l10n.counter_heigth_text(infoPoint.counterHeight),
      l10n.is_space_under_counter(
        infoPoint.isSpaceUnderCounter.toString().toLowerCase(),
      ),
    ]);
  }

  @override
  IList<String> getCommentsListForSensorySensitivity() {
    return const IList.empty();
  }
}
