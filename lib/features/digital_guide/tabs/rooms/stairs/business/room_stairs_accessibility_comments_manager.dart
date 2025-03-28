import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "../../../../../../l10n/app_localizations.dart";
import "../../../../business/accessibility_comments_manager.dart";
import "../models/room_stairs_response.dart";

class RoomStairsAccessibilityCommentsManager extends AccessibilityCommentsManager {
  RoomStairsAccessibilityCommentsManager({required this.roomStairsResponse, required this.l10n});

  final RoomStairsResponse roomStairsResponse;
  final AppLocalizations l10n;

  @override
  IList<String> getCommentsListForBlind() {
    final comments = roomStairsResponse.translations.pl;

    final IList<String> commentList =
        [
          l10n.room_stairs_stairs_width(roomStairsResponse.stairsWidth.toString()),
          "${l10n.room_stairs_are_all_steps_have_same_dimensions(roomStairsResponse.areAllStepsHaveSameDimensions.toLowerCase())} ${comments.areAllStepsHaveSameDimensionsComment}",
          "${l10n.room_stairs_is_railing(roomStairsResponse.isRailing.toLowerCase())} ${comments.isRailingComment}",
          "${l10n.room_stairs_is_round_cross_section_railing(roomStairsResponse.isRoundCrossSectionRailing.toLowerCase())} ${comments.isRailingComment}",
        ].toIList();

    return commentList;
  }

  @override
  IList<String> getCommentsListForCognitiveImpairment() {
    final comments = roomStairsResponse.translations.pl;

    final IList<String> commentList =
        [
          "${l10n.room_stairs_is_stairs_surface_shiny(roomStairsResponse.isStairsSurfaceShiny.toLowerCase())} ${comments.isStairsSurfaceShinyComment}",
        ].toIList();

    return commentList;
  }

  @override
  IList<String> getCommentsListForHearingImpairment() {
    return const IList.empty();
  }

  @override
  IList<String> getCommentsListForLowVision() {
    final comments = roomStairsResponse.translations.pl;

    final IList<String> commentList =
        [
          "${l10n.room_stairs_is_good_lit(roomStairsResponse.isGoodLit.toLowerCase())} ${comments.isGoodLitComment}",
          "${l10n.room_stairs_is_stairs_surface_shiny(roomStairsResponse.isStairsSurfaceShiny.toLowerCase())} ${comments.isStairsSurfaceShinyComment}",
          "${l10n.room_stairs_are_all_steps_have_same_dimensions(roomStairsResponse.areAllStepsHaveSameDimensions.toLowerCase())} ${comments.areAllStepsHaveSameDimensionsComment}",
          "${l10n.room_stairs_is_railing(roomStairsResponse.isRailing.toLowerCase())} ${comments.isRailingComment}",
          "${l10n.room_stairs_is_round_cross_section_railing(roomStairsResponse.isRoundCrossSectionRailing.toLowerCase())} ${comments.isRailingComment}",
          "${l10n.room_stairs_is_good_railing_contrast(roomStairsResponse.isGoodRailingContrast.toLowerCase())} ${comments.isRailingComment}",
          "${l10n.room_stairs_is_good_stairs_wall_contrast(roomStairsResponse.isGoodStairsWallContrast.toLowerCase())} ${comments.isGoodStairsWallContrastComment}",
          "${l10n.room_stairs_are_steps_edges_marked_in_contrasted_way(roomStairsResponse.areStepsEdgesMarkedInContrastedWay.toLowerCase())} ${comments.areStepsEdgesMarkedInContrastedWayComment}",
        ].toIList();

    return commentList;
  }

  @override
  IList<String> getCommentsListForMotorImpairment() {
    return const IList.empty();
  }

  @override
  IList<String> getCommentsListForSensorySensitivity() {
    return const IList.empty();
  }
}
