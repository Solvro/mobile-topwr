import "package:flutter/material.dart";
import "package:topwr/features/parkings/parkings_view/models/parking.dart";
import "package:topwr/features/parkings/parkings_view/widgets/parking_wide_tile_card.dart";
import "package:widgetbook/widgetbook.dart";

import "../../../../widgetbook_mocks.dart";

part "parking_wide_tile_card.stories.g.dart";

const meta = Meta(ParkingWideTileCard.new);

final $inactive = ParkingWideTileCardStory(
  name: "Inactive",
  args: ParkingWideTileCardArgs.fixed(parking: mockParking, onTap: () {}),
);

final $active = ParkingWideTileCardStory(
  name: "Active with chart",
  args: ParkingWideTileCardArgs.fixed(parking: mockParking, isActive: true, onTap: () {}),
);
