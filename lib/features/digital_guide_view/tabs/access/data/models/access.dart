import "package:freezed_annotation/freezed_annotation.dart";

part "digital_guide_transportation.freezed.dart";
part "digital_guide_transportation.g.dart";

@freezed
class TransportationResponse with _$TransportationResponse {
  const factory TransportationResponse({
    required int id,
    required TransportationResponseTranslations translations,
    @JsonKey(name: "nearest_public_parking_location_distance") required double nearestPublicParkingLocationDistance,
    @JsonKey(name: "is_paid_parking", fromJson: _stringToBool) required bool isPaidParking,
    @JsonKey(name: "nearest_university_parking_location_distance") required double nearestUniversityParkingLocationDistance,
    @JsonKey(name: "nearest_disabled_parking_spaces_distance") required double nearestDisabledParkingSpacesDistance,
    @JsonKey(name: "nearest_public_transport_stop_distance") required double nearestPublicTransportStopDistance,
    required String dailyTramBusLines,
    @JsonKey(name: "are_pass_traffic_lights_from_stop_to_entry", fromJson: _stringToBool) required bool arePassTrafficLightsFromStopToEntry,
    @JsonKey(name: "are_not_pass_traffic_lights_from_stop_to_entry", fromJson: _stringToBool) required bool areNotPassTrafficLightsFromStopToEntry,
    @JsonKey(name: "are_obstacles_for_wheelchair_user", fromJson: _stringToBool) required bool areObstaclesForWheelchairUser,
    @JsonKey(name: "are_obstacles_for_blind", fromJson: _stringToBool) required bool areObstaclesForBlind,
    @JsonKey(name: "are_facilities_for_blind_from_stop_to_entry", fromJson: _stringToBool) required bool areFacilitiesForBlindFromStopToEntry,
    @JsonKey(name: "alternative_public_transport_stop_distance") required double alternativePublicTransportStopDistance,
    @JsonKey(name: "alternative_daily_tram_bus_lines_stop") required String alternativeDailyTramBusLinesStop,
    @JsonKey(name: "are_pass_traffic_lights_from_stop_to_entry_alt_road", fromJson: _stringToBool) required bool? arePassTrafficLightsFromStopToEntryAltRoad,
    @JsonKey(name: "are_not_pass_traffic_lights_from_stop_to_entry_alt_road", fromJson: _stringToBool) required bool? areNotPassTrafficLightsFromStopToEntryAltRoad,
    @JsonKey(name: "are_obstacles_for_wheelchair_user_alt_road", fromJson: _stringToBool) required bool? areObstaclesForWheelchairUserAltRoad,
    @JsonKey(name: "are_obstacles_for_blind_from_stop_to_entry_alt_road", fromJson: _stringToBool) required bool? areObstaclesForBlindFromStopToEntryAltRoad,
    @JsonKey(name: "are_facilities_for_blind_from_stop_to_entry_alt_road", fromJson: _stringToBool) required bool? areFacilitiesForBlindFromStopToEntryAltRoad,
    @JsonKey(name: "are_bicycle_stands", fromJson: _stringToBool) required bool areBicycleStands,
    @JsonKey(name: "is_bicycle_path_lead_to_building", fromJson: _stringToBool) required bool isBicyclePathLeadToBuilding,
    @JsonKey(name: "distance_to_bicycle_path") required double distanceToBicyclePath,
    @JsonKey(name: "is_bicycle_path_lead_clearly_separated", fromJson: _stringToBool) required bool isBicyclePathLeadClearlySeparated,
    @JsonKey(name: "is_city_bike_station", fromJson: _stringToBool) required bool isCityBikeStation,
    @JsonKey(name: "city_bike_station_distance") required double cityBikeStationDistance,
    required int building,
    required List<int> images,
  }) = _TransportationResponse;

  factory TransportationResponse.fromJson(Map<String, dynamic> json) => _$TransportationResponseFromJson(json);
}

@freezed
class TransportationResponseTranslations with _$TransportationResponseTranslations {
  const factory TransportationResponseTranslations({
    @JsonKey(name: "pl") required TransportationResponseTranslationsDetails plTranslation,
  }) = _TransportationResponseTranslations;

  factory TransportationResponseTranslations.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$TransportationResponseTranslationsFromJson(json);
}

@freezed
class TransportationResponseTranslationsDetails with _$TransportationResponseTranslationsDetails {
  const factory TransportationResponseTranslationsDetails({
    @JsonKey(name: "nearest_public_parking_location") required String nearestPublicParkingLocation,
    @JsonKey(name: "is_paid_parking_comment") required String isPaidParkingComment,
    @JsonKey(name: "nearest_university_parking_location") required String nearestUniversityParkingLocation,
    @JsonKey(name: "nearest_disabled_parking_spaces") required String nearestDisabledParkingSpaces,
    @JsonKey(name: "nearest_public_transport_stop") required String nearestPublicTransportStop,
    @JsonKey(name: "nearest_public_transport_stop_distance_comment") required String nearestPublicTransportStopDistanceComment,
    @JsonKey(name: "are_pass_traffic_lights_from_stop_to_entry_comment") required String arePassTrafficLightsFromStopToEntryComment,
    @JsonKey(name: "are_not_pass_traffic_lights_from_stop_to_entry_comment") required String areNotPassTrafficLightsFromStopToEntryComment,
    @JsonKey(name: "are_obstacles_for_wheelchair_user_comment") required String areObstaclesForWheelchairUserComment,
    @JsonKey(name: "are_obstacles_for_blind_comment") required String areObstaclesForBlindComment,
    @JsonKey(name: "are_facilities_for_blind_from_stop_to_entry_comment") required String areFacilitiesForBlindFromStopToEntryComment,
    @JsonKey(name: "alternative_public_transport_stop") required String alternativePublicTransportStop,
    @JsonKey(name: "alternative_public_transport_stop_distance_comment") required String alternativePublicTransportStopDistanceComment,
    @JsonKey(name: "are_pass_traffic_lights_from_stop_to_entry_alt_road_comment") required String arePassTrafficLightsFromStopToEntryAltRoadComment,
    @JsonKey(name: "are_not_pass_traffic_lights_from_stop_to_entry_alt_road_comment") required String areNotPassTrafficLightsFromStopToEntryAltRoadComment,
    @JsonKey(name: "are_obstacles_for_wheelchair_user_alt_road_comment") required String areObstaclesForWheelchairUserAltRoadComment,
    @JsonKey(name: "are_obstacles_for_blind_from_stop_to_entry_alt_road_comment") required String areObstaclesForBlindFromStopToEntryAltRoadComment,
    @JsonKey(name: "are_facilities_for_blind_from_stop_to_entry_alt_road_comment") required String areFacilitiesForBlindFromStopToEntryAltRoadComment,
    @JsonKey(name: "are_bicycle_stands_comment") required String areBicycleStandsComment,
    @JsonKey(name: "is_bicycle_path_lead_to_building_comment") required String isBicyclePathLeadToBuildingComment,
    @JsonKey(name: "is_bicycle_path_lead_clearly_separated_comment") required String isBicyclePathLeadClearlySeparatedComment,
    @JsonKey(name: "is_city_bike_station_comment") required String isCityBikeStationComment,
  }) = _TransportationResponseTranslationsDetails;

  factory TransportationResponseTranslationsDetails.fromJson(Map<String, dynamic> json) => _$TransportationResponseTranslationsDetailsFromJson(json);
}

bool _stringToBool(Object? value) {
  if (value is String) {
    return value.toLowerCase() == "true";
  }
  return false;
}

