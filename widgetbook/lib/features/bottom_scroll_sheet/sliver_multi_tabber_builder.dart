import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:topwr/features/bottom_scroll_sheet/multilayer_map_single_entity_list.dart";
import "package:topwr/features/bottom_scroll_sheet/sliver_multi_tabber_builder.dart";
import "package:topwr/features/multilayer_map/data/model/multilayer_item.dart";
import "package:topwr/features/multilayer_map/data/model/multilayer_section_type.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: SliverMultiTabberBuilder)
Widget useCaseSliverMultiTabberBuilder(BuildContext context) {
  return SliverMultiTabberBuilder(
    tabs: const [
      (
        title: "Buildings",
        sectionType: MultilayerSectionType.building,
        builder: MultilayerMapSingleEntityList<BuildingItem>.new,
      ),
      (
        title: "Libraries",
        sectionType: MultilayerSectionType.library,
        builder: MultilayerMapSingleEntityList<LibraryItem>.new,
      ),
    ],
    scrollController: ScrollController(),
  );
}
