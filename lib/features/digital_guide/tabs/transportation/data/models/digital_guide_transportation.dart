import "package:freezed_annotation/freezed_annotation.dart";

import "../../../../../../utils/type_converter.dart";

part "digital_guide_transportation.freezed.dart";
part "digital_guide_transportation.g.dart";

@freezed
class DigitalGuideTransportation with _$DigitalGuideTransportation {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DigitalGuideTransportation({
    required int id,
    required int building,
    required DigitalGuideTranslationsTransportation translations,
    required double nearestPublicTransportStopDistance,
    @JsonKey(fromJson: stringToBool)
    required bool arePassTrafficLightsFromStopToEntry,
    @JsonKey(fromJson: stringToBool)
    required bool areNotPassTrafficLightsFromStopToEntry,
    required double alternativePublicTransportStopDistance,
    @JsonKey(fromJson: stringToBool)
    required bool arePassTrafficLightsFromStopToEntryAltRoad,
    @JsonKey(fromJson: stringToBool)
    required bool areNotPassTrafficLightsFromStopToEntryAltRoad,
    required double nearestPublicParkingLocationDistance,
    @JsonKey(fromJson: stringToBool) required bool isPaidParking,
    required double nearestUniversityParkingLocationDistance,
    required double nearestDisabledParkingSpacesDistance,
    @JsonKey(fromJson: stringToBool) required bool areBicycleStands,
    @JsonKey(fromJson: stringToBool) required bool isCityBikeStation,
    required double cityBikeStationDistance,
    @JsonKey(fromJson: stringToBool) required bool isBicyclePathLeadToBuilding,
    required double distanceToBicyclePath,
    @JsonKey(fromJson: stringToBool)
    required bool isBicyclePathLeadClearlySeparated,
    @JsonKey(fromJson: stringToBool) required bool areObstaclesForBlind,
    @JsonKey(fromJson: stringToBool)
    required bool areObstaclesForWheelchairUser,
    @JsonKey(fromJson: stringToBool)
    required bool areFacilitiesForBlindFromStopToEntry,
    @JsonKey(fromJson: stringToBool)
    required bool areObstaclesForWheelchairUserAltRoad,
    @JsonKey(fromJson: stringToBool)
    required bool areObstaclesForBlindFromStopToEntryAltRoad,
    @JsonKey(fromJson: stringToBool)
    required bool areFacilitiesForBlindFromStopToEntryAltRoad,
    required String dailyTramBusLines,
    required String alternativeDailyTramBusLinesStop,
  }) = _DigitalGuideTransportation;

  factory DigitalGuideTransportation.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideTransportationFromJson(json);
}

@freezed
class DigitalGuideTranslationsTransportation
    with _$DigitalGuideTranslationsTransportation {
  const factory DigitalGuideTranslationsTransportation({
    @JsonKey(name: "pl") required DigitalGuideTranslationTransportation pl,
  }) = _DigitalGuideTranslationsTransportation;

  factory DigitalGuideTranslationsTransportation.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DigitalGuideTranslationsTransportationFromJson(json);
}

@freezed
class DigitalGuideTranslationTransportation
    with _$DigitalGuideTranslationTransportation {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DigitalGuideTranslationTransportation({
    required String nearestPublicTransportStop,
    required String nearestPublicTransportStopDistanceComment,
    required String arePassTrafficLightsFromStopToEntryComment,
    required String areNotPassTrafficLightsFromStopToEntryComment,
    required String alternativePublicTransportStop,
    required String alternativePublicTransportStopDistanceComment,
    required String arePassTrafficLightsFromStopToEntryAltRoadComment,
    required String areNotPassTrafficLightsFromStopToEntryAltRoadComment,
    required String nearestPublicParkingLocation,
    required String isPaidParkingComment,
    required String nearestUniversityParkingLocation,
    required String nearestDisabledParkingSpaces,
    required String areBicycleStandsComment,
    required String isCityBikeStationComment,
    required String isBicyclePathLeadToBuildingComment,
    required String isBicyclePathLeadClearlySeparatedComment,
    required String areObstaclesForBlindComment,
    required String areFacilitiesForBlindFromStopToEntryComment,
    required String areObstaclesForWheelchairUserAltRoadComment,
    required String areObstaclesForBlindFromStopToEntryAltRoadComment,
    required String areFacilitiesForBlindFromStopToEntryAltRoadComment,
  }) = _DigitalGuideTranslationTransportation;

  factory DigitalGuideTranslationTransportation.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DigitalGuideTranslationTransportationFromJson(json);
}
