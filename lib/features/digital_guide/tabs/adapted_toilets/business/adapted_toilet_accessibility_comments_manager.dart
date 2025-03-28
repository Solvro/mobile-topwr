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
      "${l10n.adapted_toilet_is_marked(adaptedToilet.isMarked.toLowerCase())} ${pl.isMarkedComment}",
      "${l10n.adapted_toilet_is_good_floor_wall_contrast(adaptedToilet.isGoodFloorWallContrast.toLowerCase())} ${pl.isGoodFloorWallContrastComment}",
    ]);
  }

  @override
  IList<String> getCommentsListForCognitiveImpairment() {
    final pl = adaptedToilet.translations.plTranslation;
    return IList([
      "${l10n.adapted_toilet_is_marked(adaptedToilet.isMarked.toLowerCase())} ${pl.isMarkedComment}",
      "${l10n.adapted_toilet_graphically_marked(adaptedToilet.isEntranceGraphicallyMarked.toLowerCase())} ${pl.isEntranceGraphicallyMarkedComment}",
    ]);
  }

  @override
  IList<String> getCommentsListForHearingImpairment() => const IList.empty();

  @override
  IList<String> getCommentsListForLowVision() {
    final pl = adaptedToilet.translations.plTranslation;
    return IList([
      "${l10n.adapted_toilet_graphically_marked(adaptedToilet.isEntranceGraphicallyMarked.toLowerCase())} ${pl.isEntranceGraphicallyMarkedComment}",
      "${l10n.adapted_toilet_is_good_floor_wall_contrast(adaptedToilet.isGoodFloorWallContrast.toLowerCase())} ${pl.isGoodFloorWallContrastComment}",
      "${l10n.adapted_toilet_is_good_pulldown_handle_wall_contrast(adaptedToilet.isGoodPulldownHandleWallContrast.toLowerCase())} ${pl.isGoodPulldownHandleWallContrastComment}",
      "${l10n.adapted_toilet_is_good_lit(adaptedToilet.isGoodLit.toLowerCase())} ${pl.isGoodLitComment}",
    ]);
  }

  @override
  IList<String> getCommentsListForMotorImpairment() {
    final pl = adaptedToilet.translations.plTranslation;
    return IList([
      "${l10n.adapted_toilet_is_access_accessible_for_pwd(adaptedToilet.isAccessAccessibleForPwd.toLowerCase())} ${pl.isAccessAccessibleForPwdComment}",
      "${l10n.adapted_toilet_is_150x150_free_space(adaptedToilet.isFreeSpace.toLowerCase())} ${pl.isFreeSpaceComment}",
      "${l10n.adapted_toilet_is_side_maneuvering_space(adaptedToilet.isSideManeuveringSpace.toLowerCase())} ${pl.isSideManeuveringSpaceComment}",
      "${l10n.adapted_toilet_is_fixed_handle(adaptedToilet.isFixedHandle.toLowerCase())} ${pl.isFixedHandleComment}",
      "${l10n.adapted_toilet_is_space_under_washbasin_for_wheelchair(adaptedToilet.isSpaceUnderWashbasinForWheelchair.toLowerCase())} ${pl.isSpaceUnderWashbasinForWheelchairComment}",
      l10n.adapted_toilet_seat_height(adaptedToilet.toiletSeatHeight.toString()),
      "${l10n.adapted_toilet_is_wastebasket(adaptedToilet.isWastebasket.toLowerCase())} ${pl.isWastebasketComment}",
      "${l10n.adapted_toilet_is_towel_dispenser(adaptedToilet.isTowelDispenser.toLowerCase())} ${pl.isTowelDispenserComment}",
      "${l10n.adapted_toilet_is_hand_dryer(adaptedToilet.isHandDryer.toLowerCase())} ${pl.isHandDryerComment}",
    ]);
  }

  @override
  IList<String> getCommentsListForSensorySensitivity() {
    final pl = adaptedToilet.translations.plTranslation;
    return IList([
      "${l10n.adapted_toilet_is_hand_dryer(adaptedToilet.isHandDryer.toLowerCase())} ${pl.isHandDryerComment}",
      "${l10n.adapted_toilet_is_light_switch(adaptedToilet.isLightSwitch.toLowerCase())} ${pl.isLightSwitchComment}",
    ]);
  }
}
