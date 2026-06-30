import "package:flutter/widgets.dart";
import "package:topwr/features/bottom_scroll_sheet/data_list_loading.dart";
import "package:widgetbook/widgetbook.dart";

part "data_list_loading.stories.g.dart";

const meta = Meta(DataSliverListLoading.new);

final $default = DataSliverListLoadingStory(setup: (context, child, args) => CustomScrollView(slivers: [child]));
