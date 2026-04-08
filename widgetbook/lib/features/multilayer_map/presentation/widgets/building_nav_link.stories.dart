import "package:flutter/widgets.dart";
import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/multilayer_map/data/model/building.dart";
import "package:topwr/features/multilayer_map/presentation/widgets/building_nav_link.dart";
import "package:widgetbook/widgetbook.dart";

part "building_nav_link.stories.g.dart";

const _mockBuilding = Building(
  rawId: 1,
  name: "Main Building",
  naturalName: "Main Campus Building",
  addressLine1: "123 University Street",
  addressLine2: "Building A",
  latitude: 51.1079,
  longitude: 17.0385,
  externalDigitalGuideMode: null,
  externalDigitalGuideIdOrUrl: null,
  cover: null,
  branch: Branch.main,
);

const meta = Meta<BuildingNavLink>();

final $default = BuildingNavLinkStory(args: BuildingNavLinkArgs(building: Arg.fixed(_mockBuilding)));
