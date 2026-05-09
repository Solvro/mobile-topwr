import "package:flutter/widgets.dart";
import "package:topwr/api_base_rest/shared_models/image_data.dart";
import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/multilayer_map/data/model/building.dart";
import "package:topwr/features/multilayer_map/data/model/polinka_station.dart";
import "package:topwr/features/multilayer_map/presentation/widgets/polinka_tile.dart";
import "package:widgetbook/widgetbook.dart";

part "polinka_tile.stories.g.dart";

const _mockPolinkaStationWithPlaceholderPhoto = PolinkaStation(
  id: 1,
  name: "Polinka Main Station",
  campusId: 1,
  addressLine1: "123 Polinka Street",
  addressLine2: "Station A",
  photo: ImageData(url: "https://placehold.co/640x480/png?text=Polinka+Station"),
  latitude: 51.1079,
  longitude: 17.0385,
  branch: Branch.main,
  externalDigitalGuideMode: ExternalDigitalGuideMode.webUrl,
  externalDigitalGuideIdOrUrl: "https://topwr.solvro.pl/guide/8",
);

const _mockPolinkaStationWithoutPhoto = PolinkaStation(
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

final $withPlaceholderPhoto = PolinkaTileStory(
  name: "With placeholder photo, active",
  args: PolinkaTileArgs(station: Arg.fixed(_mockPolinkaStationWithPlaceholderPhoto), isActive: Arg.fixed(true)),
);

final $withoutPhoto = PolinkaTileStory(
  name: "With placeholder photo, inactive",
  args: PolinkaTileArgs(station: Arg.fixed(_mockPolinkaStationWithPlaceholderPhoto), isActive: Arg.fixed(false)),
);

final $withoutPhotoActive = PolinkaTileStory(
  name: "Without photo, active",
  args: PolinkaTileArgs(station: Arg.fixed(_mockPolinkaStationWithoutPhoto), isActive: Arg.fixed(true)),
);

final $withoutPhotoInactive = PolinkaTileStory(
  name: "Without photo, inactive",
  args: PolinkaTileArgs(station: Arg.fixed(_mockPolinkaStationWithoutPhoto), isActive: Arg.fixed(false)),
);
