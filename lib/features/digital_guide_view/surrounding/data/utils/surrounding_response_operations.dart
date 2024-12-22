import "package:flutter/widgets.dart";
import "../../../../../utils/context_extensions.dart";
import "../models/surrounding_response.dart";

List<String> getSurroundingsCommentsList(
    SurroundingResponse surroundingResponse, BuildContext context) {
  final List<String> commentsList = [];

  final comments = surroundingResponse.translations.pl;

  String parkingSpacesForPwdComment = "";

  if (comments.areParkingSpacesForPwdComment != "") {
    parkingSpacesForPwdComment = context.localize
        .parking_pwd_location(comments.areParkingSpacesForPwdComment);
  }

  final List<String> commentsListRaw = [
    comments.areNoBarriersComment,
    comments.areLoweredCurbsComment,
    comments.isPavementRoughComment,
    parkingSpacesForPwdComment,
    comments.areHighCurbsAtParkingSpaceForPwdComment,
    comments.isPathToAccessibleEntranceMarkedComment,
    comments.areDangerousElementsComment,
    comments.isLitComment,
    comments.isNoisyStreetNearBuildingComment,
    comments.isSidewalkSeparatedFromTheRoadComment,
    comments.accessibilityLevelForBlindComment,
    comments.accessibilityLevelForCognitiveDifficultiesComment,
    comments.accessibilityLevelForHardOfHearingComment,
    comments.accessibilityLevelForHighSensorySensitivityComment,
    comments.accessibilityLevelForMotorDisabilityComment,
    comments.accessibilityLevelForVisuallyImpairedComment,
    comments.comment
  ];

  for (String c in commentsListRaw) {
    if (c != "") {
      commentsList.add(c);
    }
  }

  return commentsList;
}
