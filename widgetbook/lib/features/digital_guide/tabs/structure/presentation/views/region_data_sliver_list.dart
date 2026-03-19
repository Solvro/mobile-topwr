import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/tabs/structure/presentation/views/region_data_sliver_list.dart";
import "package:topwr/features/digital_guide/tabs/structure/presentation/views/region_data_sliver_list_item.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: RegionDataSliverList)
Widget useCaseRegionDataSliverList(BuildContext context) {
  return RegionDataSliverList(
    regionDataSliverListItem: RegionDataSliverListItem(text: (index) => "Item $index", itemCount: 3),
  );
}
