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
import "../../../../data/models/level.dart";
import "../../../../data/models/region.dart";
import "../../data/models/toilet.dart";
import "../../domain/digital_guide_region_use_cases.dart";
import "region_data_sliver_list.dart";
import "region_data_sliver_list_item.dart";

@RoutePage()
class RegionView extends ConsumerWidget {
  const RegionView({
    required this.level,
    required this.region,
  });

  final Level level;
  final Region region;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final regionDataAsync =
        ref.watch(digitalGuideRegionUseCasesProvider(region));

    return regionDataAsync.when(
      data: (regionData) =>
          _RegionView(level: level, region: region, regionData: regionData),
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
    required this.level,
    required this.region,
    required this.regionData,
  });

  final Level level;
  final Region region;
  final RegionData regionData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sliverListItems = [
      RegionDataSliverListItem(
        text: (index) =>
            regionData.corridors[index].translations.plTranslation.name,
        onTap: (index) async =>
            ref.navigateDigitalGuideCorridor(regionData.corridors[index]),
        itemCount: region.corridors.length,
      ),
      RegionDataSliverListItem(
        text: (index) => context.localize.stairs,
        onTap: (index) async => () {},
        itemCount: region.corridors.length,
      ),
      RegionDataSliverListItem(
        text: (index) => context.localize.ramp,
        onTap: (index) async => () {},
        itemCount: region.corridors.length,
      ),
      RegionDataSliverListItem(
        text: (index) =>
            regionData.stairways[index].translations.plTranslation.name,
        onTap: (index) async => () {},
        itemCount: region.stairways.length,
      ),
      RegionDataSliverListItem(
        text: (index) => context.localize.lift,
        onTap: (index) async => ref.navigateLiftDetails(
          regionData.lifts[index],
          level.translations.plTranslation.name,
        ),
        itemCount: region.lifts.length,
      ),
      RegionDataSliverListItem(
        text: (index) => context.localize.lodge,
        onTap: (index) async => () {},
        itemCount: region.lodges.length,
      ),
      RegionDataSliverListItem(
        text: (index) => context.localize.information_point,
        onTap: (index) async => () {},
        itemCount: region.informationPoints.length,
      ),
      RegionDataSliverListItem(
        text: (index) => context.localize.dressing_room,
        onTap: (index) async => () {},
        itemCount: region.dressingRooms.length,
      ),
      RegionDataSliverListItem(
        text: (index) => regionData.toilets[index].toiletType == ToiletType.men
            ? context.localize.men_toilet
            : context.localize.women_toilet,
        onTap: (index) async => () {},
        itemCount: region.toilets.length,
      ),
      RegionDataSliverListItem(
        text: (index) => regionData.rooms[index].translations.pl.name,
        onTap: (index) async =>
            ref.navigateRoomDetails(regionData.rooms[index]),
        itemCount: region.rooms.length,
      ),
      RegionDataSliverListItem(
        text: (index) => context.localize.parking,
        onTap: (index) async => () {},
        itemCount: region.parkings.length,
      ),
    ];

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
                  style: context.textTheme.headline
                      .copyWith(fontSize: DigitalGuideConfig.headlineFont),
                ),
                const SizedBox(
                  height: DigitalGuideConfig.heightSmall,
                ),
                Text(
                  context.localize.region_location,
                  style: context.textTheme.boldBody
                      .copyWith(fontSize: DigitalGuideConfig.bodyFont),
                ),
                const SizedBox(
                  height: DigitalGuideConfig.heightSmall,
                ),
                Text(
                  region.translations.plTranslation.location,
                  style: context.textTheme.body
                      .copyWith(fontSize: DigitalGuideConfig.bodyFont),
                ),
                const SizedBox(
                  height: DigitalGuideConfig.heightMedium,
                ),
              ]),
            ),
            ...sliverListItems.map(
              (regionDataSliverListItem) => RegionDataSliverList(
                regionDataSliverListItem: regionDataSliverListItem,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
