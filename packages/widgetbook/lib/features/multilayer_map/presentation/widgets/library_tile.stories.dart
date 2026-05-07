import "package:flutter/widgets.dart";
import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/multilayer_map/data/model/library.dart";
import "package:topwr/features/multilayer_map/presentation/widgets/library_tile.dart";
import "package:widgetbook/widgetbook.dart";

part "library_tile.stories.g.dart";

const _mockLibrary = Library(
  rawId: 1,
  title: "Main Library",
  room: "Room 201",
  latitude: 51.1079,
  longitude: 17.0385,
  branch: Branch.main,
);

const meta = Meta<LibraryTile>();

final $default = LibraryTileStory(args: LibraryTileArgs(library: Arg.fixed(_mockLibrary)));
