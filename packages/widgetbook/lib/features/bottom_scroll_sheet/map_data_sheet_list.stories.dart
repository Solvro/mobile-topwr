import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:topwr/features/bottom_scroll_sheet/map_data_sheet_list.dart";
import "package:topwr/features/map_view/controllers/controllers_set.dart";
import "package:topwr/features/multilayer_map/data/model/multilayer_item.dart";
import "package:widgetbook/widgetbook.dart";

part "map_data_sheet_list.stories.g.dart";

final _mapScrollController = ScrollController();

const meta = Meta(MapDataSheetList.new);

final $default = MapDataSheetListStory<MultilayerItem>(
  args: MapDataSheetListArgs(scrollController: Arg.fixed(_mapScrollController)),
);
