import "package:flutter/widgets.dart";
import "package:topwr/features/bottom_scroll_sheet/multilayer_map_single_entity_list.dart";
import "package:topwr/features/multilayer_map/data/model/multilayer_item.dart";
import "package:widgetbook/widgetbook.dart";

part "multilayer_map_single_entity_list.stories.g.dart";

const meta = Meta<MultilayerMapSingleEntityList>();

final $default = MultilayerMapSingleEntityListStory<BuildingItem>(
  setup: (context, child, args) => CustomScrollView(slivers: [child]),
);
