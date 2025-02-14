import "package:auto_route/auto_route.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../presentation/widgets/accessibility_button.dart";
import "../../../presentation/widgets/bullet_list.dart";
import "../data/models/digital_guide_transportation.dart";

@RoutePage()
class TransportationDetailView extends ConsumerWidget {
  const TransportationDetailView({
    required this.transportation,
    required this.isPublic,
  });

  final DigitalGuideTransportation transportation;
  final bool isPublic;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plTransl = transportation.translations.pl;
    final publicTransport = [
      if (plTransl.nearestPublicTransportStop!.isNotEmpty)
        context.localize.nearest_public_transport_stop +
            plTransl.nearestPublicTransportStop! +
            context.distance(
              transportation.nearestPublicTransportStopDistance,
            ) +
            (plTransl.arePassTrafficLightsFromStopToEntryComment!.isNotEmpty
                ? context.localize.chose_the_path +
                    plTransl.nearestPublicTransportStopDistanceComment!
                : ""),
      if (transportation.dailyTramBusLines!.isNotEmpty)
        context.localize.transport_lines + transportation.dailyTramBusLines!,
      if (transportation.arePassTrafficLightsFromStopToEntry!)
        context.localize.pass_traffic_lights +
            plTransl.arePassTrafficLightsFromStopToEntryComment!,
      if (transportation.areNotPassTrafficLightsFromStopToEntry!)
        context.localize.no_pass_traffic_lights +
            plTransl.areNotPassTrafficLightsFromStopToEntryComment!,
      if (plTransl.alternativePublicTransportStop!.isNotEmpty)
        context.localize.nearest_public_transport_stop_alt +
            plTransl.alternativePublicTransportStop! +
            context.distance(
              transportation.alternativePublicTransportStopDistance,
            ) +
            (plTransl.alternativePublicTransportStopDistanceComment!.isNotEmpty
                ? context.localize.chose_the_path +
                    plTransl.alternativePublicTransportStopDistanceComment!
                : ""),
      if (transportation.alternativeDailyTramBusLinesStop!.isNotEmpty)
        context.localize.transport_lines +
            transportation.alternativeDailyTramBusLinesStop!,
      if (transportation.arePassTrafficLightsFromStopToEntryAltRoad!)
        context.localize.pass_traffic_lights +
            plTransl.arePassTrafficLightsFromStopToEntryAltRoadComment!,
      if (transportation.areNotPassTrafficLightsFromStopToEntryAltRoad!)
        context.localize.no_pass_traffic_lights +
            plTransl.areNotPassTrafficLightsFromStopToEntryAltRoadComment!,
    ].lock;
    final privateTransport = [
      if (plTransl.nearestPublicParkingLocation!.isNotEmpty)
        plTransl.nearestPublicParkingLocation! +
            context.distance(
              transportation.nearestPublicParkingLocationDistance,
            ) +
            plTransl.isPaidParkingComment!,
      if (plTransl.nearestUniversityParkingLocation!.isNotEmpty)
        plTransl.nearestUniversityParkingLocation! +
            context.distance(
              transportation.nearestUniversityParkingLocationDistance,
            ),
      if (plTransl.nearestDisabledParkingSpaces!.isNotEmpty)
        plTransl.nearestDisabledParkingSpaces! +
            context.distance(
              transportation.nearestDisabledParkingSpacesDistance,
            ) +
            plTransl.areBicycleStandsComment!,
      plTransl.isCityBikeStationComment! +
          context.distance(transportation.cityBikeStationDistance),
      if (transportation.isBicyclePathLeadToBuilding != null)
        context.localize.bicycle_path_leads_to_building +
            plTransl.isBicyclePathLeadToBuildingComment! +
            context.distance(transportation.distanceToBicyclePath) +
            plTransl.isBicyclePathLeadClearlySeparatedComment!,
    ].lock;
    final List<Widget> widgets = [
      Text(
        isPublic
            ? context.localize.public_transport
            : context.localize.private_transport,
        style: context.textTheme.headline.copyWith(fontSize: 20),
      ),
      const SizedBox(height: DigitalGuideConfig.heightMedium),
      BulletList(items: isPublic ? publicTransport : privateTransport),
    ];

    return Scaffold(
      appBar: DetailViewAppBar(
        actions: [AccessibilityButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: DigitalGuideConfig.heightBig,
        ),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => widgets[index],
                childCount: widgets.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension DistanceX on BuildContext {
  String distance(double? dist) {
    return (dist != null
        ? localize.distance + dist.toString() + localize.meters_abbrev
        : "");
  }
}
