import "package:flutter/widgets.dart";
import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/multilayer_map/data/model/bicycle_shower.dart";
import "package:topwr/features/multilayer_map/presentation/widgets/bicycle_shower_tile.dart";
import "package:widgetbook/widgetbook.dart";

part "bicycle_shower_tile.stories.g.dart";

const _mockBicycleShower = BicycleShower(
  rawId: 1,
  room: "Room 101",
  instructions: "Near the main entrance",
  latitude: 51.1079,
  longitude: 17.0385,
  branch: Branch.main,
);

const meta = Meta<BicycleShowerTile>();

final $default = BicycleShowerTileStory(args: BicycleShowerTileArgs(shower: Arg.fixed(_mockBicycleShower)));
