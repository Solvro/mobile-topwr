import "package:flutter/widgets.dart";
import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/multilayer_map/data/model/library.dart";
import "package:topwr/features/multilayer_map/presentation/widgets/library_tile.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

const _mockLibrary = Library(
  rawId: 1,
  title: "Main Library",
  room: "Room 201",
  latitude: 51.1079,
  longitude: 17.0385,
  branch: Branch.main,
);

@widgetbook.UseCase(name: "default", type: LibraryTile)
Widget useCaseLibraryTile(BuildContext context) {
  return const LibraryTile(_mockLibrary, isActive: true);
}
