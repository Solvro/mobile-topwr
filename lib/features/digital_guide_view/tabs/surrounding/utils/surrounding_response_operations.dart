import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "../../../../../utils/context_extensions.dart";
import "../data/models/surrounding_response_extended.dart";

IList<String> getSurroundingsCommentsList(
  SurroundingResponseExtended surroundingResponse,
  BuildContext context,
) {
  final comments = surroundingResponse.translations.plTranslation;

  final String parkingSpacesForPwdComment =
      comments.areParkingSpacesForPwdComment != ""
          ? context.localize.parking_pwd_location(
              comments.areParkingSpacesForPwdComment,
            )
          : "";

  final String areDangerousElementsComment =
      comments.areDangerousElementsComment != ""
          ? context.localize.are_dangerous_elements_comment_prefix(
              comments.areDangerousElementsComment,
            )
          : "";

  final IList<String> commentsList = [
    context.localize.are_no_barriers(
          surroundingResponse.areNoBarriers.toString(),
        ) +
        comments.areNoBarriersComment,
    context.localize.are_lowered_curbs(
          surroundingResponse.areLoweredCurbs.toString(),
        ) +
        comments.areLoweredCurbsComment,
    context.localize.is_pavement_rough(
          surroundingResponse.isPavementRough.toString(),
        ) +
        comments.isPavementRoughComment,
    parkingSpacesForPwdComment,
    context.localize.are_high_curbs_at_parking_space_for_pwd(
          surroundingResponse.areHighCurbsAtParkingSpaceForPwd.toString(),
        ) +
        comments.areHighCurbsAtParkingSpaceForPwdComment,
    comments.isPathToAccessibleEntranceMarkedComment,
    areDangerousElementsComment,
    context.localize.is_lit(
          surroundingResponse.isLit.toString(),
        ) +
        comments.isLitComment,
    context.localize.is_noisy_street_near_building(
          surroundingResponse.isNoisyStreetNearBuilding.toString(),
        ) +
        comments.isNoisyStreetNearBuildingComment,
    context.localize.is_path_to_accessible_entrance_marked(
          surroundingResponse.isPathToAccessibleEntranceMarked.toString(),
        ) +
        comments.isSidewalkSeparatedFromTheRoadComment,
    comments.accessibilityLevelForBlindComment,
    comments.accessibilityLevelForCognitiveDifficultiesComment,
    comments.accessibilityLevelForHardOfHearingComment,
    comments.accessibilityLevelForHighSensorySensitivityComment,
    comments.accessibilityLevelForMotorDisabilityComment,
    comments.accessibilityLevelForVisuallyImpairedComment,
    comments.comment,
  ].where((c) => c.isNotEmpty).toIList();

  return commentsList;
}
