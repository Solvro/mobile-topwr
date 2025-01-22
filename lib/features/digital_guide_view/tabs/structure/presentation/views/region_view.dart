import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../../config/ui_config.dart";
import "../../../../../../theme/app_theme.dart";
import "../../../../../../utils/context_extensions.dart";
import "../../../../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../../../../widgets/loading_widgets/shimmer_loading.dart";
import "../../../../../../widgets/my_error_widget.dart";
import "../../../../../navigator/utils/navigation_commands.dart";
import "../../../../data/models/region.dart";
import "../../../../presentation/widgets/digital_guide_nav_link.dart";
import "../../data/models/region_data.dart";
import "../../data/repository/region_data_repository.dart";

@RoutePage()
class RegionView extends ConsumerWidget {
  const RegionView({
    required this.region,
  });

  final Region region;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final regionDataAsync = ref.watch(regionDataRepositoryProvider(region));

    return regionDataAsync.when(
      data: (regionData) => _RegionView(region: region, regionData: regionData),
      error: (error, stackTrace) => Scaffold(
        appBar: DetailViewAppBar(),
        body: MyErrorWidget(error),
      ),
      loading: () => const Center(
        child: ShimmeringEffect(
          child: ColoredBox(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _RegionView extends ConsumerWidget {
  const _RegionView({
    required this.region,
    required this.regionData,
  });

  final Region region;
  final RegionData regionData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: DetailViewAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: DigitalGuideConfig.heightBig,
        ),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                Text(
                  region.translations.plTranslation.name,
                  style: context.textTheme.headline.copyWith(fontSize: 22),
                ),
                const SizedBox(
                  height: DigitalGuideConfig.heightSmall,
                ),
                Text(
                  context.localize.region_location,
                  style: context.textTheme.boldBody.copyWith(fontSize: 16),
                ),
                const SizedBox(
                  height: DigitalGuideConfig.heightSmall,
                ),
                Text(
                  region.translations.plTranslation.location,
                  style: context.textTheme.body.copyWith(fontSize: 16),
                ),
                const SizedBox(
                  height: DigitalGuideConfig.heightMedium,
                ),
              ]),
            ),
            // corridors
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Column(
                  children: [
                    DigitalGuideNavLink(
                      onTap: () async {
                        await ref.navigateDigitalGuideCorridor(
                          regionData.corridors[index],
                        );
                      },
                      text: regionData
                          .corridors[index].translations.plTranslation.name,
                    ),
                    const SizedBox(
                      height: DigitalGuideConfig.heightMedium,
                    ),
                  ],
                ),
                childCount: regionData.corridors.length,
              ),
            ),
            // stairs
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Column(
                  children: [
                    DigitalGuideNavLink(
                      onTap: () {},
                      text: context.localize.stairs,
                    ),
                    const SizedBox(
                      height: DigitalGuideConfig.heightMedium,
                    ),
                  ],
                ),
                childCount: regionData.stairs.length,
              ),
            ),
            // ramps
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Column(
                  children: [
                    DigitalGuideNavLink(
                      onTap: () {},
                      text: context.localize.ramp,
                    ),
                    const SizedBox(
                      height: DigitalGuideConfig.heightMedium,
                    ),
                  ],
                ),
                childCount: regionData.ramps.length,
              ),
            ),
            // stairways
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Column(
                  children: [
                    DigitalGuideNavLink(
                      onTap: () {},
                      text: regionData
                          .stairways[index].translations.plTranslation.name,
                    ),
                    const SizedBox(
                      height: DigitalGuideConfig.heightMedium,
                    ),
                  ],
                ),
                childCount: regionData.stairways.length,
              ),
            ),
            // stairways
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Column(
                  children: [
                    DigitalGuideNavLink(
                      onTap: () {},
                      text: context.localize.lift,
                    ),
                    const SizedBox(
                      height: DigitalGuideConfig.heightMedium,
                    ),
                  ],
                ),
                childCount: regionData.lifts.length,
              ),
            ),
            // lodges
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Column(
                  children: [
                    DigitalGuideNavLink(
                      onTap: () {},
                      text: context.localize.lodge,
                    ),
                    const SizedBox(
                      height: DigitalGuideConfig.heightMedium,
                    ),
                  ],
                ),
                childCount: regionData.lodges.length,
              ),
            ),
            // information points
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Column(
                  children: [
                    DigitalGuideNavLink(
                      onTap: () {},
                      text: context.localize.information_point,
                    ),
                    const SizedBox(
                      height: DigitalGuideConfig.heightMedium,
                    ),
                  ],
                ),
                childCount: regionData.informationPoints.length,
              ),
            ),
            // dressing rooms
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Column(
                  children: [
                    DigitalGuideNavLink(
                      onTap: () {},
                      text: context.localize.dressing_room,
                    ),
                    const SizedBox(
                      height: DigitalGuideConfig.heightMedium,
                    ),
                  ],
                ),
                childCount: regionData.dressingRooms.length,
              ),
            ),
            // dressing rooms
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Column(
                  children: [
                    DigitalGuideNavLink(
                      onTap: () {},
                      text: regionData.toilets[index].menToilet
                          ? context.localize.men_toilet
                          : context.localize.women_toilet,
                    ),
                    const SizedBox(
                      height: DigitalGuideConfig.heightMedium,
                    ),
                  ],
                ),
                childCount: regionData.toilets.length,
              ),
            ),
            // rooms
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Column(
                  children: [
                    DigitalGuideNavLink(
                      onTap: () async {
                        await ref.navigateRoomDetails(regionData.rooms[index]);
                      },
                      text: regionData.rooms[index].translations.pl.name,
                    ),
                    const SizedBox(
                      height: DigitalGuideConfig.heightMedium,
                    ),
                  ],
                ),
                childCount: regionData.rooms.length,
              ),
            ),
            // parkings
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Column(
                  children: [
                    DigitalGuideNavLink(
                      onTap: () async {
                        await ref.navigateRoomDetails(regionData.rooms[index]);
                      },
                      text: context.localize.parking,
                    ),
                    const SizedBox(
                      height: DigitalGuideConfig.heightMedium,
                    ),
                  ],
                ),
                childCount: regionData.parkings.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
