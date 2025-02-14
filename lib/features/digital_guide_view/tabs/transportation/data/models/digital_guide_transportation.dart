import "package:freezed_annotation/freezed_annotation.dart";

part "digital_guide_transportation.freezed.dart";
part "digital_guide_transportation.g.dart";

@freezed
class DigitalGuideTransportation with _$DigitalGuideTransportation {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DigitalGuideTransportation({
    required int id,
    required int building,
    required DigitalGuideTranslationsTransportation translations,
    double? nearestPublicTransportStopDistance,
    @JsonKey(fromJson: _stringToBool) bool? arePassTrafficLightsFromStopToEntry,
    @JsonKey(fromJson: _stringToBool)
    bool? areNotPassTrafficLightsFromStopToEntry,
    double? alternativePublicTransportStopDistance,
    @JsonKey(fromJson: _stringToBool)
    bool? arePassTrafficLightsFromStopToEntryAltRoad,
    @JsonKey(fromJson: _stringToBool)
    bool? areNotPassTrafficLightsFromStopToEntryAltRoad,
    double? nearestPublicParkingLocationDistance,
    @JsonKey(fromJson: _stringToBool) bool? isPaidParking,
    double? nearestUniversityParkingLocationDistance,
    double? nearestDisabledParkingSpacesDistance,
    @JsonKey(fromJson: _stringToBool) bool? areBicycleStands,
    @JsonKey(fromJson: _stringToBool) bool? isCityBikeStation,
    double? cityBikeStationDistance,
    @JsonKey(fromJson: _stringToBool) bool? isBicyclePathLeadToBuilding,
    double? distanceToBicyclePath,
    @JsonKey(fromJson: _stringToBool) bool? isBicyclePathLeadClearlySeparated,
    @JsonKey(fromJson: _stringToBool) bool? areObstaclesForBlind,
    @JsonKey(fromJson: _stringToBool) bool? areObstaclesForWheelchairUser,
    @JsonKey(fromJson: _stringToBool)
    bool? areFacilitiesForBlindFromStopToEntry,
    @JsonKey(fromJson: _stringToBool)
    bool? areObstaclesForWheelchairUserAltRoad,
    @JsonKey(fromJson: _stringToBool)
    bool? areObstaclesForBlindFromStopToEntryAltRoad,
    @JsonKey(fromJson: _stringToBool)
    bool? areFacilitiesForBlindFromStopToEntryAltRoad,
    String? dailyTramBusLines,
    String? alternativeDailyTramBusLinesStop,
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
    String? nearestPublicTransportStop,
    String? nearestPublicTransportStopDistanceComment,
    String? arePassTrafficLightsFromStopToEntryComment,
    String? areNotPassTrafficLightsFromStopToEntryComment,
    String? alternativePublicTransportStop,
    String? alternativePublicTransportStopDistanceComment,
    String? arePassTrafficLightsFromStopToEntryAltRoadComment,
    String? areNotPassTrafficLightsFromStopToEntryAltRoadComment,
    String? nearestPublicParkingLocation,
    String? isPaidParkingComment,
    String? nearestUniversityParkingLocation,
    String? nearestDisabledParkingSpaces,
    String? areBicycleStandsComment,
    String? isCityBikeStationComment,
    String? isBicyclePathLeadToBuildingComment,
    String? isBicyclePathLeadClearlySeparatedComment,
    String? areObstaclesForBlindComment,
    String? areFacilitiesForBlindFromStopToEntryComment,
    String? areObstaclesForWheelchairUserAltRoadComment,
    String? areObstaclesForBlindFromStopToEntryAltRoadComment,
    String? areFacilitiesForBlindFromStopToEntryAltRoadComment,
  }) = _DigitalGuideTranslationTransportation;

  factory DigitalGuideTranslationTransportation.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DigitalGuideTranslationTransportationFromJson(json);
}

bool _stringToBool(String? value) {
  return value?.toLowerCase() == "true";
}
