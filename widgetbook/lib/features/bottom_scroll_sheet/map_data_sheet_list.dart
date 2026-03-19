import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:topwr/features/bottom_scroll_sheet/map_data_sheet_list.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: MapDataSheetList)
Widget useCaseMapDataSheetList(BuildContext context) {
  return MapDataSheetList(scrollController: ScrollController());
}
