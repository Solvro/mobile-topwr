import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "../../../../../l10n/app_localizations.dart";
import "../../../business/accessibility_comments_manager.dart";
import "../data/models/digital_guide_transportation.dart";

class PublicTransportationAccessibilityCommentsManager extends AccessibilityCommentsManager {
  PublicTransportationAccessibilityCommentsManager({required this.transportation, required this.l10n});

  final DigitalGuideTransportation transportation;
  final AppLocalizations l10n;
  @override
  IList<String> getCommentsListForBlind() {
    final comments = transportation.translations.pl;

    final IList<String> commentsList =
        [
          "${l10n.transport_obstacles_for_blind(transportation.areObstaclesForBlind.toLowerCase())} ${comments.areObstaclesForBlindComment}",
          "${l10n.transport_facilities_for_blind(transportation.areFacilitiesForBlindFromStopToEntry.toLowerCase())} ${comments.areFacilitiesForBlindFromStopToEntryComment}",
          "${l10n.transport_obstacles_for_blind(transportation.areObstaclesForBlindFromStopToEntryAltRoad.toLowerCase())} ${comments.areObstaclesForBlindFromStopToEntryAltRoadComment}",
          "${l10n.transport_facilities_for_blind(transportation.areFacilitiesForBlindFromStopToEntryAltRoad.toLowerCase())} ${comments.areFacilitiesForBlindFromStopToEntryAltRoadComment}",
        ].toIList();

    return commentsList;
  }

  @override
  IList<String> getCommentsListForCognitiveImpairment() {
    final comments = transportation.translations.pl;

    final IList<String> commentsList =
        [
          "${l10n.transport_are_not_pass_traffic_lights(transportation.areNotPassTrafficLightsFromStopToEntry.toLowerCase())} ${comments.areNotPassTrafficLightsFromStopToEntryComment}",
          "${l10n.transport_are_pass_traffic_lights(transportation.arePassTrafficLightsFromStopToEntry.toLowerCase())} ${comments.arePassTrafficLightsFromStopToEntryComment}",
          "${l10n.transport_alt_are_not_pass_traffic_lights(transportation.areNotPassTrafficLightsFromStopToEntryAltRoad.toLowerCase())} ${comments.areNotPassTrafficLightsFromStopToEntryAltRoadComment}",
          "${l10n.transport_are_pass_traffic_lights(transportation.arePassTrafficLightsFromStopToEntryAltRoad.toLowerCase())} ${comments.arePassTrafficLightsFromStopToEntryAltRoadComment}",
        ].toIList();

    return commentsList;
  }

  @override
  IList<String> getCommentsListForHearingImpairment() {
    return const IList.empty();
  }

  @override
  IList<String> getCommentsListForLowVision() {
    return const IList.empty();
  }

  @override
  IList<String> getCommentsListForMotorImpairment() {
    final comments = transportation.translations.pl;

    final IList<String> commentsList =
        [
          "${l10n.transport_wheelchair_obstacles(transportation.areObstaclesForWheelchairUser.toLowerCase())} ${comments.areObstaclesForWheelchairUserComment}",
          "${l10n.transport_alt_wheelchair_obstacles(transportation.areObstaclesForWheelchairUserAltRoad.toLowerCase())} ${comments.areObstaclesForWheelchairUserAltRoadComment}",
          "${l10n.transport_are_not_pass_traffic_lights(transportation.areNotPassTrafficLightsFromStopToEntry.toLowerCase())} ${comments.areNotPassTrafficLightsFromStopToEntryComment}",
          "${l10n.transport_are_pass_traffic_lights(transportation.arePassTrafficLightsFromStopToEntry.toLowerCase())} ${comments.arePassTrafficLightsFromStopToEntryComment}",
          "${l10n.transport_alt_are_not_pass_traffic_lights(transportation.areNotPassTrafficLightsFromStopToEntryAltRoad.toLowerCase())} ${comments.areNotPassTrafficLightsFromStopToEntryAltRoadComment}",
          "${l10n.transport_are_pass_traffic_lights(transportation.arePassTrafficLightsFromStopToEntryAltRoad.toLowerCase())} ${comments.arePassTrafficLightsFromStopToEntryAltRoadComment}",
        ].toIList();

    return commentsList;
  }

  @override
  IList<String> getCommentsListForSensorySensitivity() {
    return const IList.empty();
  }
}
