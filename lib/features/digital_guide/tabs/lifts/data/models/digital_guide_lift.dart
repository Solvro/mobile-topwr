import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../../../../../../l10n/app_localizations.dart";

part "digital_guide_lift.freezed.dart";

part "digital_guide_lift.g.dart";

@freezed
class DigitalGuideLift with _$DigitalGuideLift {
  const factory DigitalGuideLift({
    required int id,
    required DigitalGuideTranslationsLift translations,
    @JsonKey(name: "images") required List<int>? imagesIds,
    @JsonKey(name: "display_in_lifts_category", fromJson: _stringToBool)
    required bool displayInLiftsCategory,
    @JsonKey(name: "is_marked_from_entrance", fromJson: _stringToBool)
    required bool isMarkedFromEntrance,
    @JsonKey(name: "is_marked_from_entrance_in_en", fromJson: _stringToBool)
    required bool isMarkedFromEntranceInEn,
    @JsonKey(name: "is_used_by") required int isUsedBy,
    @JsonKey(name: "is_signed", fromJson: _stringToBool) required bool isSigned,
    @JsonKey(name: "is_signed_in_en", fromJson: _stringToBool)
    required bool isSignedInEn,
    @JsonKey(name: "is_floor_marked", fromJson: _stringToBool)
    required bool isFloorMarked,
    @JsonKey(name: "is_glazed", fromJson: _stringToBool) required bool isGlazed,
    @JsonKey(name: "door_width") required int doorWidth,
    @JsonKey(name: "is_open_automatically", fromJson: _stringToBool)
    required bool isOpenAutomatically,
    @JsonKey(name: "door_type") required int doorType,
    @JsonKey(name: "is_increased_force_required")
    required String isIncreasedForceRequired,
    @JsonKey(name: "is_two_sided", fromJson: _stringToBool)
    required bool isTwoSided,
    @JsonKey(name: "is_mirror", fromJson: _stringToBool) required bool isMirror,
    @JsonKey(name: "is_display_floor_information", fromJson: _stringToBool)
    required bool isDisplayFloorInformation,
    @JsonKey(name: "is_voice_prompts", fromJson: _stringToBool)
    required bool isVoicePrompts,
    @JsonKey(name: "is_voice_prompts_in_en", fromJson: _stringToBool)
    required bool isVoicePromptsInEn,
    @JsonKey(name: "is_control_panel_touchscreen", fromJson: _stringToBool)
    required bool isControlPanelTouchscreen,
    @JsonKey(name: "is_inside_button_braille", fromJson: _stringToBool)
    required bool isInsideButtonBraille,
    @JsonKey(name: "is_inside_button_braille_marked")
    required String isInsideButtonBrailleMarked,
    @JsonKey(name: "is_inside_convex_button", fromJson: _stringToBool)
    required bool isInsideConvexButton,
    @JsonKey(name: "is_outside_button_braille", fromJson: _stringToBool)
    required bool isOutsideButtonBraille,
    @JsonKey(name: "is_outside_button_braille_marked")
    required String isOutsideButtonBrailleMarked,
    @JsonKey(name: "is_outside_convex_button", fromJson: _stringToBool)
    required bool isOutsideConvexButton,
    @JsonKey(name: "inside_control_panel_height")
    required int insideControlPanelHeight,
    @JsonKey(name: "outside_control_panel_height")
    required int outsideControlPanelHeight,
    @JsonKey(name: "is_inside_lit", fromJson: _stringToBool)
    required bool isInsideLit,
    @JsonKey(name: "is_railing", fromJson: _stringToBool)
    required bool isRailing,
    @JsonKey(name: "is_alarm_button", fromJson: _stringToBool)
    required bool isAlarmButton,
    @JsonKey(name: "is_display_showing_floor", fromJson: _stringToBool)
    required bool isDisplayShowingFloor,
    @JsonKey(
      name: "is_outside_arrival_notification_sound",
      fromJson: _stringToBool,
    )
    required bool isOutsideArrivalNotificationSound,
    @JsonKey(
      name: "is_inside_arrival_notification_sound",
      fromJson: _stringToBool,
    )
    required bool isInsideArrivalNotificationSound,
    @JsonKey(name: "is_good_door_wall_contrast", fromJson: _stringToBool)
    required bool isGoodDoorWallContrast,
  }) = _DigitalGuideLift;

  const DigitalGuideLift._();

  IList<String> getMotorImpairmentValue(AppLocalizations l10n) {
    final pl = translations.pl;
    return IList([
      l10n.lift_width_text(doorWidth),
      l10n.lift_dimensions_text + translations.pl.liftDimensions,
      if (isGlazed) l10n.lift_glazed,
      l10n.control_panel_inside(insideControlPanelHeight),
      l10n.control_panel_outside(outsideControlPanelHeight),
      if (isRailing) pl.isRailingComment,
    ]);
  }

  IList<String> getBlindImpairmentValue(AppLocalizations l10n) {
    final pl = translations.pl;
    return IList([
      if (isSigned) l10n.lift_info_boart_text,
      l10n.lift_width_text(doorWidth),
      if (isVoicePrompts) l10n.with_voice_comunicates,
      if (isInsideButtonBraille)
        l10n.with_inside_braile_comunicates
      else
        l10n.without_inside_braile_comunicates,
      l10n.lift_dimensions_text + pl.liftDimensions,
      if (isGlazed) l10n.lift_glazed,
      l10n.control_panel_inside(insideControlPanelHeight),
      l10n.control_panel_outside(outsideControlPanelHeight),
      if (isInsideConvexButton) l10n.lift_button_are_convex,
      l10n.is_with_outsite_notification(
        isOutsideArrivalNotificationSound.toString().toLowerCase(),
      ),
      l10n.is_with_inside_notification(
        isOutsideArrivalNotificationSound.toString().toLowerCase(),
      ),
    ]);
  }

  IList<String> getLowVisionImpairment(AppLocalizations l10n) {
    return IList([
      if (isVoicePrompts) l10n.with_voice_comunicates,
      if (isInsideConvexButton) l10n.lift_button_are_convex,
      l10n.is_lit(isInsideLit.toString().toLowerCase()),
      l10n.is_with_outsite_notification(
        isOutsideArrivalNotificationSound.toString().toLowerCase(),
      ),
      l10n.is_with_inside_notification(
        isOutsideArrivalNotificationSound.toString().toLowerCase(),
      ),
      l10n.is_door_good_contrast(
        isGoodDoorWallContrast.toString().toLowerCase(),
      ),
    ]);
  }

  IList<String> getSensorySensitivityImpairment(AppLocalizations l10n) {
    return IList([
      l10n.is_lift_floor_info(isDisplayShowingFloor.toString().toLowerCase()),
    ]);
  }

  IList<String> getCognitiveImpairment(AppLocalizations l10n) {
    return IList(
      [
        if (isSigned) l10n.lift_info_boart_text,
        l10n.is_lit(isInsideLit.toString().toLowerCase()),
      ],
    );
  }

  factory DigitalGuideLift.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideLiftFromJson(json);
}

@freezed
class DigitalGuideTranslationsLift with _$DigitalGuideTranslationsLift {
  const factory DigitalGuideTranslationsLift({
    required DigitalGuideTranslationLift pl,
  }) = _DigitalGuideTranslationsLift;

  factory DigitalGuideTranslationsLift.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideTranslationsLiftFromJson(json);
}

@freezed
class DigitalGuideTranslationLift with _$DigitalGuideTranslationLift {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DigitalGuideTranslationLift({
    required String location,
    required String floorsList,
    required String maximumLiftCapacity,
    required String liftDimensions,
    required String isRailingComment,
  }) = _DigitalGuideTranslationLift;

  factory DigitalGuideTranslationLift.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideTranslationLiftFromJson(json);
}

bool _stringToBool(String value) {
  return value.toLowerCase() == "true";
}
