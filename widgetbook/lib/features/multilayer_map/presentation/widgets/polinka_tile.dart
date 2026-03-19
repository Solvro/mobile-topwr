import "package:flutter/widgets.dart";
import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/multilayer_map/data/model/polinka_station.dart";
import "package:topwr/features/multilayer_map/presentation/widgets/polinka_tile.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

const _mockPolinkaStation = PolinkaStation(
  id: 1,
  name: "Polinka Main Station",
  campusId: 1,
  addressLine1: "123 Polinka Street",
  addressLine2: "Station A",
  latitude: 51.1079,
  longitude: 17.0385,
  branch: Branch.main,
  externalDigitalGuideMode: null,
  externalDigitalGuideIdOrUrl: null,
);

@widgetbook.UseCase(name: "default", type: PolinkaTile)
Widget useCasePolinkaTile(BuildContext context) {
  return const PolinkaTile(_mockPolinkaStation, isActive: true);
}
