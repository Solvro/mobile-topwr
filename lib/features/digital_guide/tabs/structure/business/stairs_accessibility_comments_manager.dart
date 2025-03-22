import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "../../../../../l10n/app_localizations.dart";
import "../../../business/accessibility_comments_manager.dart";
import "../data/models/stairs.dart";

class StairsAccessibilityCommentsManager extends AccessibilityCommentsManager {
  StairsAccessibilityCommentsManager({required this.stairs, required this.l10n});

  final Stairs stairs;
  final AppLocalizations l10n;

  @override
  IList<String> getCommentsListForBlind() {
    final StairsTranslation pl = stairs.translations.plTranslation;

    return IList([
      "${l10n.stairs_is_stairs_sign_info(stairs.isStairsSignInfo.toLowerCase())} ${pl.isStairsSignInfoComment}",
      "${l10n.stairs_is_stairs_sign_info_in_en(stairs.isStairsSignInfoInEn.toLowerCase())} ${pl.isStairsSignInfoInEnComment}",
      "${l10n.stairs_is_nonslip_surface(stairs.isNonslipSurface.toLowerCase())} ${pl.isNonslipSurfaceComment}",
      "${l10n.stairs_are_first_and_last_steps_marked(stairs.areFirstAndLastStepsMarked.toLowerCase())} ${pl.areFirstAndLastStepsMarkedComment}",
      "${l10n.stairs_are_grades_nose_pads(stairs.areGradesNosePads.toLowerCase())} ${pl.areGradesNosePadsComment}",
      "${l10n.stairs_are_steps_raised_markings(stairs.areStepsRaisedMarkings.toLowerCase())} ${pl.areStepsRaisedMarkingsComment}",
      "${l10n.stairs_is_properly_marked_free_space_under_stairs(stairs.isProperlyMarkedFreeSpaceUnderStairs.toLowerCase())} ${pl.isProperlyMarkedFreeSpaceUnderStairsComment}",
    ]).toIList();
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
    final StairsTranslation pl = stairs.translations.plTranslation;
    return IList([
      "${l10n.stairs_is_good_lit(stairs.isGoodLit.toLowerCase())} ${pl.isGoodLitComment}",
      "${l10n.stairs_is_stairs_surface_shiny(stairs.isStairsSurfaceShiny.toLowerCase())} ${pl.isStairsSurfaceShinyComment}",
      "${l10n.stairs_is_good_stairs_wall_contrast(stairs.isGoodStairsWallContrast.toLowerCase())} ${pl.isGoodStairsWallContrastComment}",
    ]).toIList();
  }

  @override
  IList<String> getCommentsListForMotorImpairment() {
    final StairsTranslation pl = stairs.translations.plTranslation;
    return IList([
      if (pl.numberOfStairGears.isNotEmpty) "${l10n.number_of_stair_gears} ${pl.numberOfStairGears}",
      if (pl.numberOfStairLandings.isNotEmpty) "${l10n.number_of_stair_landings} ${pl.numberOfStairLandings}",
    ]);
  }

  @override
  IList<String> getCommentsListForSensorySensitivity() {
    return const IList.empty();
  }
}
