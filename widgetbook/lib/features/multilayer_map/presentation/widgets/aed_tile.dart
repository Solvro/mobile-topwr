import "package:flutter/widgets.dart";
import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/multilayer_map/data/model/aed.dart";
import "package:topwr/features/multilayer_map/presentation/widgets/aed_tile.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

const _mockAed = Aed(
  rawId: 1,
  latitude: 51.1079,
  longitude: 17.0385,
  photo: null,
  addressLine1: "Main Campus Building",
  addressLine2: null,
  branch: Branch.main,
);

@widgetbook.UseCase(name: "default", type: AedTile)
Widget useCaseAedTile(BuildContext context) {
  return const AedTile(_mockAed, isActive: true);
}
