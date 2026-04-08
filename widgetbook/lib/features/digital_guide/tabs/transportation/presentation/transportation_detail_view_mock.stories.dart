import "package:flutter/material.dart";
import "package:topwr/features/digital_guide/tabs/transportation/data/models/digital_guide_transportation.dart";
import "package:topwr/features/digital_guide/tabs/transportation/presentation/transportation_detail_view.dart";
import "package:widgetbook/widgetbook.dart";

part "transportation_detail_view_mock.stories.g.dart";

class TransportationDetailViewMockStory extends StatelessWidget {
  const TransportationDetailViewMockStory({super.key});

  @override
  Widget build(BuildContext context) {
    const translation = DigitalGuideTranslationTransportation(
      nearestPublicTransportStop: "Example",
      nearestPublicTransportStopDistanceComment: "Example",
      arePassTrafficLightsFromStopToEntryComment: "Example",
      areNotPassTrafficLightsFromStopToEntryComment: "Example",
      alternativePublicTransportStop: "Example",
      alternativePublicTransportStopDistanceComment: "Example",
      arePassTrafficLightsFromStopToEntryAltRoadComment: "Example",
      areNotPassTrafficLightsFromStopToEntryAltRoadComment: "Example",
      nearestPublicParkingLocation: "Example",
      isPaidParkingComment: "Example",
      nearestUniversityParkingLocation: "Example",
      nearestDisabledParkingSpaces: "Example",
      areBicycleStandsComment: "Example",
      isCityBikeStationComment: "Example",
      isBicyclePathLeadToBuildingComment: "Example",
      isBicyclePathLeadClearlySeparatedComment: "Example",
      areObstaclesForWheelchairUserComment: "Example",
      areObstaclesForBlindComment: "Example",
      areFacilitiesForBlindFromStopToEntryComment: "Example",
      areObstaclesForWheelchairUserAltRoadComment: "Example",
      areObstaclesForBlindFromStopToEntryAltRoadComment: "Example",
      areFacilitiesForBlindFromStopToEntryAltRoadComment: "Example",
    );

    const translations = DigitalGuideTranslationsTransportation(pl: translation);

    const mockTransportation = DigitalGuideTransportation(
      id: 1,
      building: 1,
      translations: translations,
      nearestPublicTransportStopDistance: 100,
      arePassTrafficLightsFromStopToEntry: "yes",
      areNotPassTrafficLightsFromStopToEntry: "no",
      alternativePublicTransportStopDistance: 200,
      arePassTrafficLightsFromStopToEntryAltRoad: "yes",
      areNotPassTrafficLightsFromStopToEntryAltRoad: "no",
      nearestPublicParkingLocationDistance: 50,
      isPaidParking: "yes",
      nearestUniversityParkingLocationDistance: 80,
      nearestDisabledParkingSpacesDistance: 30,
      areBicycleStands: "yes",
      isCityBikeStation: "yes",
      cityBikeStationDistance: 20,
      isBicyclePathLeadToBuilding: "yes",
      distanceToBicyclePath: 15,
      isBicyclePathLeadClearlySeparated: "yes",
      areObstaclesForBlind: "no",
      areObstaclesForWheelchairUser: "no",
      areFacilitiesForBlindFromStopToEntry: "yes",
      areObstaclesForWheelchairUserAltRoad: "no",
      areObstaclesForBlindFromStopToEntryAltRoad: "no",
      areFacilitiesForBlindFromStopToEntryAltRoad: "yes",
      dailyTramBusLines: "Line 1, Line 2",
      alternativeDailyTramBusLinesStop: "Line 3",
    );

    return const TransportationDetailView(transportation: mockTransportation, isPublic: true);
  }
}

const meta = Meta<TransportationDetailViewMockStory>();

final $withMockData = TransportationDetailViewMockStoryStory();
