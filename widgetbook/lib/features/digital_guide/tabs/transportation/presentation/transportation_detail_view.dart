import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:topwr/features/digital_guide/data/models/digital_guide_response.dart";
import "package:topwr/features/digital_guide/tabs/transportation/data/models/digital_guide_transportation.dart";
import "package:topwr/features/digital_guide/tabs/transportation/data/repository/transportation_repository.dart";
import "package:topwr/features/digital_guide/tabs/transportation/presentation/transportation_detail_view.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "with-mock-data", type: TransportationDetailView)
Widget useCaseTransportationDetailViewMock(BuildContext context) {
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

@widgetbook.UseCase(name: "from-production", type: TransportationDetailView)
Widget useCaseTransportationDetailViewProduction(BuildContext context) {
  return const _TransportationDetailViewFromRepository();
}

class _TransportationDetailViewFromRepository extends ConsumerWidget {
  const _TransportationDetailViewFromRepository();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Provide a minimal DigitalGuideResponse for widgetbook purposes
    const demoGuideResponse = DigitalGuideResponse(
      id: 1,
      externalId: 1,
      translations: DigitalGuideTranslations(
        plTranslation: DigitalGuideTranslation(
          name: "Demo",
          extendedName: "Demo Extended",
          address: "123 Demo St",
          evacuationDescription: "Follow signs to exit.",
        ),
      ),
      numberOfStoreys: 1,
      canAssistanceDog: true,
      isInductionLoop: false,
      isMicroNavigationSystem: false,
      areGuidancePaths: false,
      areBrailleBoards: false,
      areLargeFontBoards: false,
      isSignLanguageInterpreter: false,
      areEmergencyChairs: false,
      phoneNumbers: ["000-000-000"],
      surroundingId: 1,
      images: [],
      evacuationMapId: 1,
      locationMapId: 1,
      levelsIndices: [1],
      accessId: 1,
      accessibilityLevelForMotorDisability: 1,
      accessibilityLevelForBlind: 1,
      accessibilityLevelForVisuallyImpaired: 1,
      accessibilityLevelForHardOfHearing: 1,
      accessibilityLevelForHighSensorySensitivity: 1,
      accessibilityLevelForCognitiveDifficulties: 1,
    );
    final asyncTransportation = ref.watch(transportationRepositoryProvider.call(demoGuideResponse));

    return asyncTransportation.when(
      data: (transportation) {
        return TransportationDetailView(transportation: transportation, isPublic: true);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text("Error loading transportation data: $error")),
    );
  }
}
