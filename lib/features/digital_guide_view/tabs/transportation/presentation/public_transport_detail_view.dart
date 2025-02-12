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
class PublicTransportDetailView extends ConsumerWidget {
  const PublicTransportDetailView({
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
                  .translations.pl.nearestPublicTransportStop !=
              "")
            context.localize.nearest_public_transport_stop +
                transportationResponse
                    .translations.pl.nearestPublicTransportStop! +
                (transportationResponse.nearestPublicTransportStopDistance !=
                        null
                    ? context.localize.distance +
                        transportationResponse
                            .nearestPublicTransportStopDistance
                            .toString() +
                        context.localize.meters
                    : "") +
                (transportationResponse.translations.pl
                            .nearestPublicTransportStopDistanceComment !=
                        ""
                    ? context.localize.chose_the_path +
                        transportationResponse.translations.pl
                            .nearestPublicTransportStopDistanceComment!
                    : "") +
                (transportationResponse.translations.pl.dailyTramBusLines !=
                        null
                    ? context.localize.transport_lines +
                        transportationResponse
                            .translations.pl.dailyTramBusLines!
                    : ""),
          if (transportationResponse.arePassTrafficLightsFromStopToEntry!)
            context.localize.pass_traffic_lights +
                (transportationResponse.translations.pl
                            .arePassTrafficLightsFromStopToEntryComment !=
                        ""
                    ? transportationResponse.translations.pl
                        .arePassTrafficLightsFromStopToEntryComment!
                    : ""),
          if (transportationResponse.areNotPassTrafficLightsFromStopToEntry!)
            context.localize.no_pass_traffic_lights +
                (transportationResponse.translations.pl
                            .areNotPassTrafficLightsFromStopToEntryComment !=
                        ""
                    ? transportationResponse.translations.pl
                        .areNotPassTrafficLightsFromStopToEntryComment!
                    : ""),
          if (transportationResponse
                  .translations.pl.alternativePublicTransportStop !=
              "")
            context.localize.nearest_public_transport_stop_alt +
                transportationResponse
                    .translations.pl.alternativePublicTransportStop! +
                (transportationResponse
                            .alternativePublicTransportStopDistance !=
                        null
                    ? context.localize.distance +
                        transportationResponse
                            .alternativePublicTransportStopDistance
                            .toString() +
                        context.localize.meters
                    : "") +
                (transportationResponse.translations.pl
                            .alternativePublicTransportStopDistanceComment !=
                        ""
                    ? context.localize.chose_the_path +
                        transportationResponse.translations.pl
                            .alternativePublicTransportStopDistanceComment!
                    : "") +
                (transportationResponse
                            .translations.pl.alternativeDailyTramBusLinesStop !=
                        ""
                    ? context.localize.transport_lines +
                        transportationResponse
                            .translations.pl.alternativeDailyTramBusLinesStop!
                    : ""),
          if (transportationResponse
              .arePassTrafficLightsFromStopToEntryAltRoad!)
            context.localize.pass_traffic_lights +
                (transportationResponse.translations.pl
                            .arePassTrafficLightsFromStopToEntryAltRoadComment !=
                        ""
                    ? transportationResponse.translations.pl
                        .arePassTrafficLightsFromStopToEntryAltRoadComment!
                    : ""),
          if (transportationResponse
              .areNotPassTrafficLightsFromStopToEntryAltRoad!)
            context.localize.no_pass_traffic_lights +
                (transportationResponse.translations.pl
                            .areNotPassTrafficLightsFromStopToEntryAltRoadComment !=
                        ""
                    ? transportationResponse.translations.pl
                        .areNotPassTrafficLightsFromStopToEntryAltRoadComment!
                    : ""),
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
