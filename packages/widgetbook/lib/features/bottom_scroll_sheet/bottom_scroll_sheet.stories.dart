import "package:flutter/widgets.dart";
import "package:topwr/features/bottom_scroll_sheet/bottom_scroll_sheet.dart";
import "package:topwr/features/map_view/controllers/controllers_set.dart";
import "package:topwr/features/multilayer_map/data/model/multilayer_item.dart";
import "package:widgetbook/widgetbook.dart";

part "bottom_scroll_sheet.stories.g.dart";

const meta = Meta<BottomScrollSheet>();

final $default = BottomScrollSheetStory<MultilayerItem>(
  setup: (context, child, args) => SizedBox(height: 700, child: child),
);
