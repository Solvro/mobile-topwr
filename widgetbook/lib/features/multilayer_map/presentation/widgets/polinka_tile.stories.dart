import "package:flutter/widgets.dart";
import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/multilayer_map/data/model/building.dart";
import "package:topwr/features/multilayer_map/data/model/polinka_station.dart";
import "package:topwr/features/multilayer_map/presentation/widgets/polinka_tile.dart";
import "package:widgetbook/widgetbook.dart";

part "polinka_tile.stories.g.dart";

const _mockPolinkaStation = PolinkaStation(
  id: 1,
  name: "Polinka Main Station",
  campusId: 1,
  addressLine1: "123 Polinka Street",
  addressLine2: "Station A",
  latitude: 51.1079,
  longitude: 17.0385,
  branch: Branch.main,
  externalDigitalGuideMode: ExternalDigitalGuideMode.webUrl,
  externalDigitalGuideIdOrUrl: "https://topwr.solvro.pl/guide/8",
);

const meta = Meta<PolinkaTile>();

final $default = PolinkaTileStory(args: PolinkaTileArgs(station: Arg.fixed(_mockPolinkaStation)));
