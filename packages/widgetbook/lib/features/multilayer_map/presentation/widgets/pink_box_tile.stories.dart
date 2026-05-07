import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/multilayer_map/data/model/pink_box.dart";
import "package:topwr/features/multilayer_map/presentation/widgets/pink_box_tile.dart";
import "package:widgetbook/widgetbook.dart";

part "pink_box_tile.stories.g.dart";

const _mockPinkBox = PinkBox(rawId: 1, roomOrNearby: "Room 101", latitude: 51.1, longitude: 16.9, branch: Branch.main);

class PinkBoxTileStoryKnobs {
  final bool isActive;
  PinkBoxTileStoryKnobs({required this.isActive});
}

const meta = MetaWithArgs<PinkBoxTile, PinkBoxTileStoryKnobs>();

final defaults = _Defaults(builder: (context, args) => PinkBoxTile(_mockPinkBox, isActive: args.isActive));

final $default = PinkBoxTileStory();
