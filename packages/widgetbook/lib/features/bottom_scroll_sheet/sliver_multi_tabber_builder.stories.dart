import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:topwr/features/bottom_scroll_sheet/multilayer_map_single_entity_list.dart";
import "package:topwr/features/bottom_scroll_sheet/sliver_multi_tabber_builder.dart";
import "package:topwr/features/multilayer_map/data/model/multilayer_item.dart";
import "package:topwr/features/multilayer_map/data/model/multilayer_section_type.dart";
import "package:widgetbook/widgetbook.dart";

part "sliver_multi_tabber_builder.stories.g.dart";

final _scrollController = ScrollController();

const meta = Meta<SliverMultiTabberBuilder>();

final $default = SliverMultiTabberBuilderStory(
  setup: (context, child, args) => CustomScrollView(
    controller: args.scrollController,
    slivers: [child],
  ),
  args: SliverMultiTabberBuilderArgs(
    scrollController: Arg.fixed(_scrollController),
    tabs: Arg.fixed([
      (
        title: "Tab",
        sectionType: MultilayerSectionType.building,
        builder: () => const MultilayerMapSingleEntityList<BuildingItem>(),
      ),
    ]),
  ),
);
