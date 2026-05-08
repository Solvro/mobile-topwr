import "package:topwr/api_base_rest/shared_models/image_data.dart";
import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/multilayer_map/data/model/pink_box.dart";
import "package:topwr/features/multilayer_map/presentation/widgets/pink_box_tile.dart";
import "package:widgetbook/widgetbook.dart";

part "pink_box_tile.stories.g.dart";

const _mockPinkBoxWithPlaceholderPhoto = PinkBox(
  rawId: 1,
  roomOrNearby: "Room 101",
  photo: ImageData(url: "https://placehold.co/640x480/png?text=Pink+Box"),
  latitude: 51.1,
  longitude: 16.9,
  branch: Branch.main,
);

const _mockPinkBoxWithoutPhoto = PinkBox(
  rawId: 1,
  roomOrNearby: "Room 101",
  latitude: 51.1,
  longitude: 16.9,
  branch: Branch.main,
);

class PinkBoxTileStoryKnobs {
  final bool isActive;
  PinkBoxTileStoryKnobs({required this.isActive});
}

const meta = MetaWithArgs<PinkBoxTile, PinkBoxTileStoryKnobs>();

final defaults = _Defaults(
  builder: (context, args) => PinkBoxTile(_mockPinkBoxWithPlaceholderPhoto, isActive: args.isActive),
);

final $withPlaceholderPhoto = PinkBoxTileStory(
  name: "With placeholder photo, active",
  args: PinkBoxTileStoryKnobsArgs(isActive: Arg.fixed(true)),
);

final $withoutPhoto = PinkBoxTileStory(
  name: "With placeholder photo, inactive",
  args: PinkBoxTileStoryKnobsArgs(isActive: Arg.fixed(false)),
);

final $withoutPhotoActive = PinkBoxTileStory(
  name: "Without photo, active",
  builder: (context, args) => PinkBoxTile(_mockPinkBoxWithoutPhoto, isActive: args.isActive),
  args: PinkBoxTileStoryKnobsArgs(isActive: Arg.fixed(true)),
);

final $withoutPhotoInactive = PinkBoxTileStory(
  name: "Without photo, inactive",
  builder: (context, args) => PinkBoxTile(_mockPinkBoxWithoutPhoto, isActive: args.isActive),
  args: PinkBoxTileStoryKnobsArgs(isActive: Arg.fixed(false)),
);
