import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/tabs/structure/presentation/views/region_data_sliver_list.dart";
import "package:topwr/features/digital_guide/tabs/structure/presentation/views/region_data_sliver_list_item.dart";
import "package:widgetbook/widgetbook.dart";

part "region_data_sliver_list.stories.g.dart";

final _mockRegionDataSliverListItem = RegionDataSliverListItem(
  text: (index) => "Region item ${index + 1}",
  itemCount: 5,
);

const meta = Meta(RegionDataSliverList.new);

final $default = RegionDataSliverListStory(
  setup: (context, child, args) => CustomScrollView(slivers: [child]),
  args: RegionDataSliverListArgs(regionDataSliverListItem: Arg.fixed(_mockRegionDataSliverListItem)),
);
