import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "../../../../../l10n/app_localizations.dart";
import "../../../business/accessibility_comments_manager.dart";
import "../data/models/surrounding_response.dart";

class SurroundingsAccessibilityCommentsManager
    extends AccessibilityCommentsManager {
  SurroundingsAccessibilityCommentsManager({
    required this.surroundingResponse,
    required this.l10n,
  });

  final SurroundingResponse surroundingResponse;
  final AppLocalizations l10n;

  @override
  IList<String> getCommentsListForBlind() {
    final comments = surroundingResponse.translations.plTranslation;

    final String parkingSpacesForPwdComment =
        comments.areParkingSpacesForPwdComment != ""
            ? l10n.parking_pwd_location(
                comments.areParkingSpacesForPwdComment,
              )
            : "";

    final String areDangerousElementsComment =
        comments.areDangerousElementsComment != ""
            ? l10n.are_dangerous_elements_comment_prefix(
                comments.areDangerousElementsComment,
              )
            : "";

    final IList<String> commentsList = [
      l10n.are_no_barriers(
            surroundingResponse.areNoBarriers.toString(),
          ) +
          comments.areNoBarriersComment,
      l10n.are_lowered_curbs(
            surroundingResponse.areLoweredCurbs.toString(),
          ) +
          comments.areLoweredCurbsComment,
      l10n.is_pavement_rough(
            surroundingResponse.isPavementRough.toString(),
          ) +
          comments.isPavementRoughComment,
      parkingSpacesForPwdComment,
      l10n.are_high_curbs_at_parking_space_for_pwd(
            surroundingResponse.areHighCurbsAtParkingSpaceForPwd.toString(),
          ) +
          comments.areHighCurbsAtParkingSpaceForPwdComment,
      comments.isPathToAccessibleEntranceMarkedComment,
      areDangerousElementsComment,
      l10n.is_path_to_accessible_entrance_marked(
            surroundingResponse.isPathToAccessibleEntranceMarked.toString(),
          ) +
          comments.isSidewalkSeparatedFromTheRoadComment,
      comments.accessibilityLevelForBlindComment,
      comments.comment,
    ].where((c) => c.isNotEmpty).toIList();

    return commentsList;
  }

  @override
  IList<String> getCommentsListForCognitiveImpairment() {
    final comments = surroundingResponse.translations.plTranslation;

    final String parkingSpacesForPwdComment =
        comments.areParkingSpacesForPwdComment != ""
            ? l10n.parking_pwd_location(
                comments.areParkingSpacesForPwdComment,
              )
            : "";

    final IList<String> commentsList = [
      parkingSpacesForPwdComment,
      comments.accessibilityLevelForCognitiveDifficultiesComment,
      comments.comment,
    ].where((c) => c.isNotEmpty).toIList();

    return commentsList;
  }

  @override
  IList<String> getCommentsListForHearingImpairment() {
    final comments = surroundingResponse.translations.plTranslation;

    final String parkingSpacesForPwdComment =
        comments.areParkingSpacesForPwdComment != ""
            ? l10n.parking_pwd_location(
                comments.areParkingSpacesForPwdComment,
              )
            : "";

    final IList<String> commentsList = [
      parkingSpacesForPwdComment,
      comments.accessibilityLevelForHardOfHearingComment,
      comments.comment,
    ].where((c) => c.isNotEmpty).toIList();

    return commentsList;
  }

  @override
  IList<String> getCommentsListForLowVision() {
    final comments = surroundingResponse.translations.plTranslation;

    final String parkingSpacesForPwdComment =
        comments.areParkingSpacesForPwdComment != ""
            ? l10n.parking_pwd_location(
                comments.areParkingSpacesForPwdComment,
              )
            : "";

    final IList<String> commentsList = [
      parkingSpacesForPwdComment,
      l10n.is_lit(
            surroundingResponse.isLit.toString(),
          ) +
          comments.isLitComment,
      comments.accessibilityLevelForVisuallyImpairedComment,
      comments.comment,
    ].where((c) => c.isNotEmpty).toIList();

    return commentsList;
  }

  @override
  IList<String> getCommentsListForMotorImpairment() {
    final comments = surroundingResponse.translations.plTranslation;

    final String parkingSpacesForPwdComment =
        comments.areParkingSpacesForPwdComment != ""
            ? l10n.parking_pwd_location(
                comments.areParkingSpacesForPwdComment,
              )
            : "";

    final IList<String> commentsList = [
      l10n.are_no_barriers(
            surroundingResponse.areNoBarriers.toString(),
          ) +
          comments.areNoBarriersComment,
      l10n.are_lowered_curbs(
            surroundingResponse.areLoweredCurbs.toString(),
          ) +
          comments.areLoweredCurbsComment,
      l10n.is_pavement_rough(
            surroundingResponse.isPavementRough.toString(),
          ) +
          comments.isPavementRoughComment,
      parkingSpacesForPwdComment,
      l10n.are_high_curbs_at_parking_space_for_pwd(
            surroundingResponse.areHighCurbsAtParkingSpaceForPwd.toString(),
          ) +
          comments.areHighCurbsAtParkingSpaceForPwdComment,
      comments.isPathToAccessibleEntranceMarkedComment,
      comments.accessibilityLevelForMotorDisabilityComment,
      comments.comment,
    ].where((c) => c.isNotEmpty).toIList();

    return commentsList;
  }

  @override
  IList<String> getCommentsListForSensorySensitivity() {
    final comments = surroundingResponse.translations.plTranslation;

    final String parkingSpacesForPwdComment =
        comments.areParkingSpacesForPwdComment != ""
            ? l10n.parking_pwd_location(
                comments.areParkingSpacesForPwdComment,
              )
            : "";

    final IList<String> commentsList = [
      parkingSpacesForPwdComment,
      l10n.is_noisy_street_near_building(
            surroundingResponse.isNoisyStreetNearBuilding.toString(),
          ) +
          comments.isNoisyStreetNearBuildingComment,
      comments.accessibilityLevelForHighSensorySensitivityComment,
      comments.comment,
    ].where((c) => c.isNotEmpty).toIList();

    return commentsList;
  }
}
