import "package:flutter/widgets.dart";
import "package:topwr/api_base_rest/shared_models/image_data.dart";
import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/multilayer_map/data/model/library.dart";
import "package:topwr/features/multilayer_map/presentation/widgets/library_tile.dart";
import "package:widgetbook/widgetbook.dart";
import "../../../../widgetbook_placeholders.dart";

part "library_tile.stories.g.dart";

const _mockLibraryWithPlaceholderPhoto = Library(
  rawId: 1,
  title: "Main Library",
  room: "Room 201",
  photo: ImageData(url: widgetbookPlaceholderImageUrl),
  latitude: 51.1079,
  longitude: 17.0385,
  branch: Branch.main,
);

const _mockLibraryWithoutPhoto = Library(
  rawId: 1,
  title: "Main Library",
  room: "Room 201",
  latitude: 51.1079,
  longitude: 17.0385,
  branch: Branch.main,
);

const meta = Meta<LibraryTile>();

final $withPlaceholderPhoto = LibraryTileStory(
  name: "With placeholder photo, active",
  args: LibraryTileArgs(library: Arg.fixed(_mockLibraryWithPlaceholderPhoto), isActive: Arg.fixed(true)),
);

final $withoutPhoto = LibraryTileStory(
  name: "With placeholder photo, inactive",
  args: LibraryTileArgs(library: Arg.fixed(_mockLibraryWithPlaceholderPhoto), isActive: Arg.fixed(false)),
);

final $withoutPhotoActive = LibraryTileStory(
  name: "Without photo, active",
  args: LibraryTileArgs(library: Arg.fixed(_mockLibraryWithoutPhoto), isActive: Arg.fixed(true)),
);

final $withoutPhotoInactive = LibraryTileStory(
  name: "Without photo, inactive",
  args: LibraryTileArgs(library: Arg.fixed(_mockLibraryWithoutPhoto), isActive: Arg.fixed(false)),
);
