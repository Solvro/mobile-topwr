import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "../../../../../l10n/app_localizations.dart";
import "../../../utils/accessibility_comments_manager.dart";
import "../data/models/digital_guide_lift.dart";

class LiftsAccessibilityCommentsManager extends AccessibilityCommentsManager {
  LiftsAccessibilityCommentsManager({
    required this.l10n,
    required this.liftResponse,
  });

  AppLocalizations l10n;
  DigitalGuideLift liftResponse;

  @override
  IList<String> getCommentsListForBlind() {
    final pl = liftResponse.translations.pl;
    return IList([
      if (liftResponse.isSigned) l10n.lift_info_boart_text,
      l10n.lift_width_text(liftResponse.doorWidth),
      if (liftResponse.isVoicePrompts) l10n.with_voice_comunicates,
      if (liftResponse.isInsideButtonBraille)
        l10n.with_inside_braile_comunicates
      else
        l10n.without_inside_braile_comunicates,
      l10n.lift_dimensions_text + pl.liftDimensions,
      if (liftResponse.isGlazed) l10n.lift_glazed,
      l10n.control_panel_inside(liftResponse.insideControlPanelHeight),
      l10n.control_panel_outside(liftResponse.outsideControlPanelHeight),
      if (liftResponse.isInsideConvexButton) l10n.lift_button_are_convex,
      l10n.is_with_outsite_notification(
        liftResponse.isOutsideArrivalNotificationSound.toString().toLowerCase(),
      ),
      l10n.is_with_inside_notification(
        liftResponse.isOutsideArrivalNotificationSound.toString().toLowerCase(),
      ),
    ]);
  }

  @override
  IList<String> getCommentsListForCognitiveImpairment() {
    return IList(
      [
        if (liftResponse.isSigned) l10n.lift_info_boart_text,
        l10n.is_lit(liftResponse.isInsideLit.toString().toLowerCase()),
      ],
    );
  }

  @override
  IList<String> getCommentsListForHearingImpairment() {
    // TODO(thesun901): Implement hearing impairment comments for lifts
    return IList(const []);
  }

  @override
  IList<String> getCommentsListForLowVision() {
    return IList([
      if (liftResponse.isVoicePrompts) l10n.with_voice_comunicates,
      if (liftResponse.isInsideConvexButton) l10n.lift_button_are_convex,
      l10n.is_lit(liftResponse.isInsideLit.toString().toLowerCase()),
      l10n.is_with_outsite_notification(
        liftResponse.isOutsideArrivalNotificationSound.toString().toLowerCase(),
      ),
      l10n.is_with_inside_notification(
        liftResponse.isOutsideArrivalNotificationSound.toString().toLowerCase(),
      ),
      l10n.is_door_good_contrast(
        liftResponse.isGoodDoorWallContrast.toString().toLowerCase(),
      ),
    ]);
  }

  @override
  IList<String> getCommentsListForMotorImpairment() {
    final pl = liftResponse.translations.pl;
    return IList([
      l10n.lift_width_text(liftResponse.doorWidth),
      l10n.lift_dimensions_text + pl.liftDimensions,
      if (liftResponse.isGlazed) l10n.lift_glazed,
      l10n.control_panel_inside(liftResponse.insideControlPanelHeight),
      l10n.control_panel_outside(liftResponse.outsideControlPanelHeight),
      if (liftResponse.isRailing) pl.isRailingComment,
    ]);
  }

  @override
  IList<String> getCommentsListForSensorySensitivity() {
    return IList([
      l10n.is_lift_floor_info(
        liftResponse.isDisplayShowingFloor.toString().toLowerCase(),
      ),
    ]);
  }
}
