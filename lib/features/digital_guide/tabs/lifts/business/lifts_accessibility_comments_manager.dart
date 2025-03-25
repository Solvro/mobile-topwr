import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "../../../../../l10n/app_localizations.dart";
import "../../../business/accessibility_comments_manager.dart";
import "../data/models/digital_guide_lift.dart";

class LiftsAccessibilityCommentsManager extends AccessibilityCommentsManager {
  LiftsAccessibilityCommentsManager({required this.l10n, required this.liftResponse});

  AppLocalizations l10n;
  DigitalGuideLift liftResponse;

  @override
  IList<String> getCommentsListForBlind() {
    final pl = liftResponse.translations.pl;
    return IList([
      l10n.lift_info_board_text(liftResponse.isSigned.toLowerCase()),
      l10n.lift_width_text(liftResponse.doorWidth),
      l10n.lift_with_voice_comunicates(liftResponse.isVoicePrompts.toLowerCase()),
      l10n.lift_with_inside_braile_comunicates(liftResponse.isInsideButtonBraille.toLowerCase()),
      "${l10n.lift_dimensions_text} ${pl.liftDimensions}",
      l10n.lift_is_mirror(liftResponse.isMirror.toLowerCase()),
      l10n.lift_control_panel_inside(liftResponse.insideControlPanelHeight),
      l10n.lift_control_panel_outside(liftResponse.outsideControlPanelHeight),
      l10n.lift_button_are_convex(liftResponse.isInsideConvexButton.toLowerCase()),
      l10n.lift_is_with_outside_notification(liftResponse.isOutsideArrivalNotificationSound.toLowerCase()),
      l10n.lift_is_with_inside_notification(liftResponse.isInsideArrivalNotificationSound.toLowerCase()),
    ]).toIList();
  }

  @override
  IList<String> getCommentsListForCognitiveImpairment() {
    return IList([
      l10n.lift_info_board_text(liftResponse.isSigned.toLowerCase()),
      l10n.lift_is_inside_lit(liftResponse.isInsideLit.toLowerCase()),
    ]).where((e) => e.isNotEmpty).toIList();
  }

  @override
  IList<String> getCommentsListForHearingImpairment() => const IListConst([]);

  @override
  IList<String> getCommentsListForLowVision() {
    return IList([
      l10n.lift_with_voice_comunicates(liftResponse.isVoicePrompts.toLowerCase()),
      l10n.lift_button_are_convex(liftResponse.isInsideConvexButton.toLowerCase()),
      l10n.lift_is_inside_lit(liftResponse.isInsideLit.toLowerCase()),
      l10n.lift_is_with_outside_notification(liftResponse.isOutsideArrivalNotificationSound.toLowerCase()),
      l10n.lift_is_with_inside_notification(liftResponse.isInsideArrivalNotificationSound.toLowerCase()),
      l10n.lift_is_door_good_contrast(liftResponse.isGoodDoorWallContrast.toLowerCase()),
    ]);
  }

  @override
  IList<String> getCommentsListForMotorImpairment() {
    final pl = liftResponse.translations.pl;
    return IList([
      l10n.lift_width_text(liftResponse.doorWidth),
      "${l10n.lift_dimensions_text} ${pl.liftDimensions}",
      l10n.lift_is_mirror(liftResponse.isMirror.toLowerCase()),
      l10n.lift_control_panel_inside(liftResponse.insideControlPanelHeight),
      l10n.lift_control_panel_outside(liftResponse.outsideControlPanelHeight),
      pl.isRailingComment,
    ]).where((e) => e.isNotEmpty).toIList();
  }

  @override
  IList<String> getCommentsListForSensorySensitivity() {
    return IList([l10n.is_lift_floor_info(liftResponse.isDisplayShowingFloor.toLowerCase())]);
  }
}
