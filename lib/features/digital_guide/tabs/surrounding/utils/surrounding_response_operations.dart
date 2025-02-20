import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";

import "../../../../../utils/context_extensions.dart";
import "../data/models/surrounding_response.dart";

extension SurroundingResponseOperationsX on BuildContext {
  IList<String> getSurroundingsCommentsList(
    SurroundingResponse surroundingResponse,
  ) {
    final comments = surroundingResponse.translations.plTranslation;

    final String parkingSpacesForPwdComment =
        comments.areParkingSpacesForPwdComment != ""
            ? localize.parking_pwd_location(
                comments.areParkingSpacesForPwdComment,
              )
            : "";

    final String areDangerousElementsComment =
        comments.areDangerousElementsComment != ""
            ? localize.are_dangerous_elements_comment_prefix(
                comments.areDangerousElementsComment,
              )
            : "";

    final IList<String> commentsList = [
      localize.are_no_barriers(
            surroundingResponse.areNoBarriers.toString(),
          ) +
          comments.areNoBarriersComment,
      localize.are_lowered_curbs(
            surroundingResponse.areLoweredCurbs.toString(),
          ) +
          comments.areLoweredCurbsComment,
      localize.is_pavement_rough(
            surroundingResponse.isPavementRough.toString(),
          ) +
          comments.isPavementRoughComment,
      parkingSpacesForPwdComment,
      localize.are_high_curbs_at_parking_space_for_pwd(
            surroundingResponse.areHighCurbsAtParkingSpaceForPwd.toString(),
          ) +
          comments.areHighCurbsAtParkingSpaceForPwdComment,
      comments.isPathToAccessibleEntranceMarkedComment,
      areDangerousElementsComment,
      localize.is_lit(
            surroundingResponse.isLit.toString(),
          ) +
          comments.isLitComment,
      localize.is_noisy_street_near_building(
            surroundingResponse.isNoisyStreetNearBuilding.toString(),
          ) +
          comments.isNoisyStreetNearBuildingComment,
      localize.is_path_to_accessible_entrance_marked(
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
}
