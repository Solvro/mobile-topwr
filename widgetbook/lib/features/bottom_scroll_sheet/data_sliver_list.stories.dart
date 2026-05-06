import "package:flutter/widgets.dart";
import "package:topwr/features/bottom_scroll_sheet/data_list.dart";
import "package:topwr/features/map_view/controllers/controllers_set.dart";
import "package:topwr/features/multilayer_map/data/model/multilayer_item.dart";
import "package:widgetbook/widgetbook.dart";

part "data_sliver_list.stories.g.dart";

const meta = Meta<DataSliverList>();

final $default = DataSliverListStory<MultilayerItem>(
  setup: (context, child, args) => CustomScrollView(slivers: [child]),
);
