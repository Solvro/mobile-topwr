import "package:flutter/widgets.dart";
import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/multilayer_map/data/model/pink_box.dart";
import "package:topwr/features/multilayer_map/presentation/widgets/pink_box_tile.dart";
import "package:widgetbook/widgetbook.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

const _mockPinkBox = PinkBox(rawId: 1, roomOrNearby: "Room 101", latitude: 51.1, longitude: 16.9, branch: Branch.main);

@widgetbook.UseCase(name: "default", type: PinkBoxTile)
Widget useCasePinkBoxTile(BuildContext context) {
  return PinkBoxTile(_mockPinkBox, isActive: context.knobs.boolean(label: "Is active"));
}
