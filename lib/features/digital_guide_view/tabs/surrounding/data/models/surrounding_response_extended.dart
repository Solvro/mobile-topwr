import "dart:core";
import "surrounding_response.dart";

class SurroundingResponseExtended {
  const SurroundingResponseExtended({
    required this.id,
    required this.translations,
    required this.areNoBarriers,
    required this.areLoweredCurbs,
    required this.isPavementRough,
    required this.areParkingSpaces,
    required this.areParkingSpacesForPwd,
    required this.areHighCurbsAtParkingSpaceForPwd,
    required this.isPathToAccessibleEntranceMarked,
    required this.areDangerousElements,
    required this.isLit,
    required this.isNoisyStreetNearBuilding,
    required this.isSidewalkSeparatedFromTheRoad,
    required this.accessibilityLevelForMotorDisability,
    required this.accessibilityLevelForBlind,
    required this.accessibilityLevelForVisuallyImpaired,
    required this.accessibilityLevelForHardOfHearing,
    required this.accessibilityLevelForHighSensorySensitivity,
    required this.accessibilityLevelForCognitiveDifficulties,
    required this.building,
    required this.images,
    required this.imagesUrl,
  });

  final int id;
  final SurroundingResponseTranslations translations;
  final bool areNoBarriers;
  final bool areLoweredCurbs;
  final bool isPavementRough;
  final bool areParkingSpaces;
  final bool areParkingSpacesForPwd;
  final bool areHighCurbsAtParkingSpaceForPwd;
  final bool isPathToAccessibleEntranceMarked;
  final bool areDangerousElements;
  final bool isLit;
  final bool isNoisyStreetNearBuilding;
  final bool isSidewalkSeparatedFromTheRoad;
  final int accessibilityLevelForMotorDisability;
  final int accessibilityLevelForBlind;
  final int accessibilityLevelForVisuallyImpaired;
  final int accessibilityLevelForHardOfHearing;
  final int accessibilityLevelForHighSensorySensitivity;
  final int accessibilityLevelForCognitiveDifficulties;
  final int building;
  final List<int> images;
  final List<String?>? imagesUrl;

  factory SurroundingResponseExtended.fromSurroundingResponse({
    required SurroundingResponse surroundingResponse,
    required List<String?>? imagesUrl,
  }) {
    return SurroundingResponseExtended(
      id: surroundingResponse.id,
      translations: surroundingResponse.translations,
      areNoBarriers: surroundingResponse.areNoBarriers,
      areLoweredCurbs: surroundingResponse.areLoweredCurbs,
      isPavementRough: surroundingResponse.isPavementRough,
      areParkingSpaces: surroundingResponse.areParkingSpaces,
      areParkingSpacesForPwd: surroundingResponse.areParkingSpacesForPwd,
      areHighCurbsAtParkingSpaceForPwd:
          surroundingResponse.areHighCurbsAtParkingSpaceForPwd,
      isPathToAccessibleEntranceMarked:
          surroundingResponse.isPathToAccessibleEntranceMarked,
      areDangerousElements: surroundingResponse.areDangerousElements,
      isLit: surroundingResponse.isLit,
      isNoisyStreetNearBuilding: surroundingResponse.isNoisyStreetNearBuilding,
      isSidewalkSeparatedFromTheRoad:
          surroundingResponse.isSidewalkSeparatedFromTheRoad,
      accessibilityLevelForMotorDisability:
          surroundingResponse.accessibilityLevelForMotorDisability,
      accessibilityLevelForBlind:
          surroundingResponse.accessibilityLevelForBlind,
      accessibilityLevelForVisuallyImpaired:
          surroundingResponse.accessibilityLevelForVisuallyImpaired,
      accessibilityLevelForHardOfHearing:
          surroundingResponse.accessibilityLevelForHardOfHearing,
      accessibilityLevelForHighSensorySensitivity:
          surroundingResponse.accessibilityLevelForHighSensorySensitivity,
      accessibilityLevelForCognitiveDifficulties:
          surroundingResponse.accessibilityLevelForCognitiveDifficulties,
      building: surroundingResponse.building,
      images: surroundingResponse.images,
      imagesUrl: imagesUrl,
    );
  }
}
