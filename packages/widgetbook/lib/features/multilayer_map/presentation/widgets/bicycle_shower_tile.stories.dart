import "package:flutter/widgets.dart";
import "package:topwr/api_base_rest/shared_models/image_data.dart";
import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/multilayer_map/data/model/bicycle_shower.dart";
import "package:topwr/features/multilayer_map/presentation/widgets/bicycle_shower_tile.dart";
import "package:widgetbook/widgetbook.dart";

part "bicycle_shower_tile.stories.g.dart";

const _mockBicycleShowerWithPlaceholderPhoto = BicycleShower(
  rawId: 1,
  room: "Room 101",
  instructions: "Near the main entrance",
  photo: ImageData(url: "https://placehold.co/640x480/png?text=Bicycle+Shower"),
  latitude: 51.1079,
  longitude: 17.0385,
  branch: Branch.main,
);

const _mockBicycleShowerWithoutPhoto = BicycleShower(
  rawId: 1,
  room: "Room 101",
  instructions: "Near the main entrance",
  latitude: 51.1079,
  longitude: 17.0385,
  branch: Branch.main,
);

const meta = Meta<BicycleShowerTile>();

final $withPlaceholderPhoto = BicycleShowerTileStory(
  name: "With placeholder photo, active",
  args: BicycleShowerTileArgs(shower: Arg.fixed(_mockBicycleShowerWithPlaceholderPhoto), isActive: Arg.fixed(true)),
);

final $withoutPhoto = BicycleShowerTileStory(
  name: "With placeholder photo, inactive",
  args: BicycleShowerTileArgs(shower: Arg.fixed(_mockBicycleShowerWithPlaceholderPhoto), isActive: Arg.fixed(false)),
);

final $withoutPhotoActive = BicycleShowerTileStory(
  name: "Without photo, active",
  args: BicycleShowerTileArgs(shower: Arg.fixed(_mockBicycleShowerWithoutPhoto), isActive: Arg.fixed(true)),
);

final $withoutPhotoInactive = BicycleShowerTileStory(
  name: "Without photo, inactive",
  args: BicycleShowerTileArgs(shower: Arg.fixed(_mockBicycleShowerWithoutPhoto), isActive: Arg.fixed(false)),
);
