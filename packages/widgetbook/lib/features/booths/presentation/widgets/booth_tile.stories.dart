import "package:flutter/widgets.dart";
import "package:topwr/features/booths/data/models/booth.dart";
import "package:topwr/features/booths/presentation/widgets/booth_tile.dart";
import "package:widgetbook/widgetbook.dart";

import "../../../../widgetbook_mocks.dart";

part "booth_tile.stories.g.dart";

const meta = Meta(BoothTile.new);

final $available = BoothTileStory(
  name: "Available",
  args: BoothTileArgs(booth: Arg.fixed(mockBooths[0])),
);

final $occupied = BoothTileStory(
  name: "Occupied",
  args: BoothTileArgs(booth: Arg.fixed(mockBooths[1])),
);

final $offline = BoothTileStory(
  name: "Offline",
  args: BoothTileArgs(booth: Arg.fixed(mockBooths[2])),
);
