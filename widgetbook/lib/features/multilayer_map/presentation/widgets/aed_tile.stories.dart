import "package:flutter/widgets.dart";
import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/multilayer_map/data/model/aed.dart";
import "package:topwr/features/multilayer_map/presentation/widgets/aed_tile.dart";
import "package:widgetbook/widgetbook.dart";

part "aed_tile.stories.g.dart";

const _mockAed = Aed(
  rawId: 1,
  latitude: 51.1079,
  longitude: 17.0385,
  photo: null,
  addressLine1: "Main Campus Building",
  addressLine2: null,
  branch: Branch.main,
);

const meta = Meta<AedTile>();

final $default = AedTileStory(args: AedTileArgs(aed: Arg.fixed(_mockAed)));
