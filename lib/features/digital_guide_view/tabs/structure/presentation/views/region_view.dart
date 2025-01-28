import "dart:async";

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
import "../../domain/digital_guide_region_use_cases.dart";

@RoutePage()
class RegionView extends ConsumerWidget {
  const RegionView({
    required this.region,
  });

  final Region region;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final regionDataAsync =
        ref.watch(digitalGuideRegionUrseCasesProvider(region));

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
        onTap: (index) async => () {},
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
        text: (index) => regionData.toilets[index].menToilet
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

class RegionDataSliverList extends ConsumerWidget {
  const RegionDataSliverList({
    required this.regionDataSliverListItem,
  });

  final RegionDataSliverListItem regionDataSliverListItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Column(
          children: [
            DigitalGuideNavLink(
              onTap: () async => regionDataSliverListItem.onTap?.call(index),
              text: regionDataSliverListItem.text(index),
            ),
            const SizedBox(
              height: DigitalGuideConfig.heightMedium,
            ),
          ],
        ),
        childCount: regionDataSliverListItem.itemCount,
      ),
    );
  }
}

class RegionDataSliverListItem {
  final String Function(int) text;
  final Future<void> Function(int index)? onTap;
  final int itemCount;

  RegionDataSliverListItem({
    required this.text,
    this.onTap,
    required this.itemCount,
  });
}
