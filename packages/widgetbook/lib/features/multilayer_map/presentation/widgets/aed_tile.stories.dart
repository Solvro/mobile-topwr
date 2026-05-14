import "package:flutter/widgets.dart";
import "package:topwr/api_base_rest/shared_models/image_data.dart";
import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/multilayer_map/data/model/aed.dart";
import "package:topwr/features/multilayer_map/presentation/widgets/aed_tile.dart";
import "package:widgetbook/widgetbook.dart";
import "../../../../widgetbook_placeholders.dart";

part "aed_tile.stories.g.dart";

const _mockAedWithPlaceholderPhoto = Aed(
  rawId: 1,
  latitude: 51.1079,
  longitude: 17.0385,
  photo: ImageData(url: widgetbookPlaceholderImageUrl),
  addressLine1: "Main Campus Building",
  addressLine2: "Hol główny, obok portierni",
  instructions: "AED znajduje się przy portierni, obok wejścia głównego.",
  branch: Branch.main,
);

const _mockAedWithoutPhoto = Aed(
  rawId: 1,
  latitude: 51.1079,
  longitude: 17.0385,
  photo: null,
  addressLine1: "Main Campus Building",
  addressLine2: "Hol główny, obok portierni",
  instructions: "AED znajduje się przy portierni, obok wejścia głównego.",
  branch: Branch.main,
);

const meta = Meta<AedTile>();

final $withPlaceholderPhoto = AedTileStory(
  name: "With placeholder photo, active",
  args: AedTileArgs(aed: Arg.fixed(_mockAedWithPlaceholderPhoto), isActive: Arg.fixed(true)),
);

final $withoutPhoto = AedTileStory(
  name: "With placeholder photo, inactive",
  args: AedTileArgs(aed: Arg.fixed(_mockAedWithPlaceholderPhoto), isActive: Arg.fixed(false)),
);

final $withoutPhotoActive = AedTileStory(
  name: "Without photo, active",
  args: AedTileArgs(aed: Arg.fixed(_mockAedWithoutPhoto), isActive: Arg.fixed(true)),
);

final $withoutPhotoInactive = AedTileStory(
  name: "Without photo, inactive",
  args: AedTileArgs(aed: Arg.fixed(_mockAedWithoutPhoto), isActive: Arg.fixed(false)),
);
