import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "../../../../../l10n/app_localizations.dart";
import "../../../business/accessibility_comments_manager.dart";
import "../data/models/adapted_toilet.dart";

class AdaptedToiletsAccessibilityCommentsManager extends AccessibilityCommentsManager {
  AdaptedToiletsAccessibilityCommentsManager({required this.l10n, required this.adaptedToilet});

  AppLocalizations l10n;
  AdaptedToilet adaptedToilet;

  @override
  IList<String> getCommentsListForBlind() {
    final pl = adaptedToilet.translations.plTranslation;
    return IList([
      if (adaptedToilet.isMarked)
        l10n.adapted_toilet_is_marked(pl.isMarkedComment)
      else
        l10n.adapted_toilet_is_not_marked,
      if (adaptedToilet.isGoodFloorWallContrast)
        l10n.adapted_toilet_is_good_floor_wall_contrast(pl.isGoodFloorWallContrastComment)
      else
        l10n.adapted_toilet_is_not_good_floor_wall_contrast,
    ]);
  }

  @override
  IList<String> getCommentsListForCognitiveImpairment() {
    final pl = adaptedToilet.translations.plTranslation;
    return IList([
      if (adaptedToilet.isMarked)
        l10n.adapted_toilet_is_marked(pl.isMarkedComment)
      else
        l10n.adapted_toilet_is_not_marked,
      if (adaptedToilet.isEntranceGraphicallyMarked)
        l10n.adapted_toilet_graphically_marked(pl.isEntranceGraphicallyMarkedComment)
      else
        l10n.adapted_toilet_not_graphically_marked,
    ]);
  }

  @override
  IList<String> getCommentsListForHearingImpairment() {
    return IList(const []);
  }

  @override
  IList<String> getCommentsListForLowVision() {
    final pl = adaptedToilet.translations.plTranslation;
    return IList([
      if (adaptedToilet.isEntranceGraphicallyMarked)
        l10n.adapted_toilet_graphically_marked(pl.isEntranceGraphicallyMarkedComment)
      else
        l10n.adapted_toilet_not_graphically_marked,
      if (adaptedToilet.isGoodFloorWallContrast)
        l10n.adapted_toilet_is_good_floor_wall_contrast(pl.isGoodFloorWallContrastComment)
      else
        l10n.adapted_toilet_is_not_good_floor_wall_contrast,
      if (adaptedToilet.isGoodPulldownHandleWallContrast)
        l10n.adapted_toilet_is_good_pulldown_handle_wall_contrast(pl.isGoodPulldownHandleWallContrastComment)
      else
        l10n.adapted_toilet_is_not_good_pulldown_handle_wall_contrast,
      if (adaptedToilet.isGoodLit)
        l10n.adapted_toilet_is_good_lit(pl.isGoodLitComment)
      else
        l10n.adapted_toilet_is_not_good_lit,
    ]);
  }

  @override
  IList<String> getCommentsListForMotorImpairment() {
    final pl = adaptedToilet.translations.plTranslation;
    return IList([
      if (adaptedToilet.isAccessAccessibleForPwd)
        l10n.adapted_toilet_is_access_accessible_for_pwd(pl.isAccessAccessibleForPwdComment)
      else
        l10n.adapted_toilet_is_access_not_accessible_for_pwd,
      if (adaptedToilet.isFreeSpace)
        l10n.adapted_toilet_is_150x150_free_space(pl.is150x150FreeSpaceComment)
      else
        l10n.adapted_toilet_is_not_150x150_free_space,
      if (adaptedToilet.isSideManeuveringSpace)
        l10n.adapted_toilet_is_side_maneuvering_space(pl.isSideManeuveringSpaceComment)
      else
        l10n.adapted_toilet_is_not_side_maneuvering_space,
      if (adaptedToilet.isFixedHandle) pl.isFixedHandleComment else l10n.adapted_toilet_is_not_fixed_handle,
      if (adaptedToilet.isSpaceUnderWashbasinForWheelchair)
        l10n.adapted_toilet_is_space_under_washbasin_for_wheelchair(pl.isSpaceUnderWashbasinForWheelchairComment)
      else
        l10n.adapted_toilet_is_not_space_under_washbasin_for_wheelchair,
      l10n.adapted_toilet_seat_hight(adaptedToilet.toiletSeatHeight.toString()),
      if (adaptedToilet.isWastebasket)
        l10n.adapted_toilet_is_wastebasket(pl.isWastebasketComment)
      else
        l10n.adapted_toilet_is_not_wastebasket,
      if (adaptedToilet.isTowelDispenser)
        l10n.adapted_toilet_is_towel_dispenser(pl.isTowelDispenserComment)
      else
        l10n.adapted_toilet_is_not_towel_dispenser,
      if (adaptedToilet.isHandDryer)
        l10n.adapted_toilet_is_hand_dryer(pl.isHandDryerComment)
      else
        l10n.adapted_toilet_is_not_hand_dryer,
    ]);
  }

  @override
  IList<String> getCommentsListForSensorySensitivity() {
    final pl = adaptedToilet.translations.plTranslation;
    return IList([
      if (adaptedToilet.isHandDryer)
        l10n.adapted_toilet_is_hand_dryer(pl.isHandDryerComment)
      else
        l10n.adapted_toilet_is_not_hand_dryer,
      if (adaptedToilet.isLightSwitch)
        l10n.adapted_toilet_is_light_switch(pl.isLightSwitchComment)
      else
        l10n.adapted_toilet_is_not_light_switch,
    ]);
  }
}
