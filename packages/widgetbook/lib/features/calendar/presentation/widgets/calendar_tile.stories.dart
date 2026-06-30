import "package:flutter/widgets.dart";
import "package:topwr/features/calendar/presentation/widgets/calendar_tile.dart";
import "package:topwr/theme/hex_color.dart";
import "package:widgetbook/widgetbook.dart";

part "calendar_tile.stories.g.dart";

final _productionCalendarItem = (
  name: "Matematyka dyskretna",
  location: "Budynek G, sala 204",
  hoursString: "09:15 - 10:45",
  description: "Wykład prowadzony przez dr hab. Kowalskiego",
  accentColor: HexColor("#2962FF"), // realistic Wroclaw Tech color
);

const meta = Meta(CalendarTile.new);

final $default = CalendarTileStory(args: CalendarTileArgs(item: Arg.fixed(_productionCalendarItem)));
