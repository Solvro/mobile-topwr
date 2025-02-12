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
class PrivateTransportDetailView extends ConsumerWidget {
  const PrivateTransportDetailView({
    required this.transportationResponse,
  });

  final DigitalGuideTransportation transportationResponse;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Widget> widgets = [
      Text(
        context.localize.private_transport,
        style: context.textTheme.headline.copyWith(fontSize: 20),
      ),
      const SizedBox(height: DigitalGuideConfig.heightMedium),
      BulletList(
        items: [
          if (transportationResponse
                  .translations.pl.nearestPublicParkingLocation !=
              "")
            transportationResponse
                    .translations.pl.nearestPublicParkingLocation! +
                (transportationResponse.nearestPublicParkingLocationDistance !=
                        null
                    ? context.localize.distance +
                        transportationResponse
                            .nearestPublicParkingLocationDistance
                            .toString() +
                        context.localize.meters
                    : ""),
          if (transportationResponse.translations.pl.isPaidParkingComment != "")
            transportationResponse.translations.pl.isPaidParkingComment!,
          if (transportationResponse
                  .translations.pl.nearestUniversityParkingLocation !=
              "")
            transportationResponse
                    .translations.pl.nearestUniversityParkingLocation! +
                (transportationResponse
                            .nearestUniversityParkingLocationDistance !=
                        null
                    ? context.localize.distance +
                        transportationResponse
                            .nearestUniversityParkingLocationDistance
                            .toString() +
                        context.localize.meters
                    : ""),
          if (transportationResponse
                  .translations.pl.nearestDisabledParkingSpaces !=
              "")
            transportationResponse
                    .translations.pl.nearestDisabledParkingSpaces! +
                (transportationResponse.nearestDisabledParkingSpacesDistance !=
                        null
                    ? context.localize.distance +
                        transportationResponse
                            .nearestDisabledParkingSpacesDistance
                            .toString() +
                        context.localize.meters
                    : ""),
          if (transportationResponse.translations.pl.areBicycleStandsComment !=
              "")
            transportationResponse.translations.pl.areBicycleStandsComment!,
          if (transportationResponse.translations.pl.isCityBikeStationComment !=
              "")
            transportationResponse.translations.pl.isCityBikeStationComment! +
                (transportationResponse.cityBikeStationDistance != null
                    ? context.localize.distance +
                        transportationResponse.cityBikeStationDistance
                            .toString() +
                        context.localize.meters
                    : ""),
          if (transportationResponse.isBicyclePathLeadToBuilding != null)
            "${context.localize.bicycle_path_to_building}${transportationResponse.translations.pl.isBicyclePathLeadToBuildingComment != "" ? transportationResponse.translations.pl.isBicyclePathLeadToBuildingComment! : ""} ${transportationResponse.distanceToBicyclePath != null ? context.localize.distance + transportationResponse.distanceToBicyclePath.toString() + context.localize.meters : ""} ${transportationResponse.translations.pl.isBicyclePathLeadClearlySeparatedComment != "" ? transportationResponse.translations.pl.isBicyclePathLeadClearlySeparatedComment! : ""}",
        ].lock,
      ),
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
