import "package:topwr/features/sks/sks_menu/data/models/sks_opening_hours.dart";
import "package:topwr/features/sks/sks_menu/presentation/widgets/sks_menu_header.dart";
import "package:widgetbook/widgetbook.dart";

part "sks_menu_header.stories.g.dart";

const _mockOpeningHours = OpeningHours(
  canteen: VenueHours(openingTime: "10:00", closingTime: "16:00"),
  cafe: VenueHours(openingTime: "08:00", closingTime: "20:00"),
);

class SksMenuHeaderStoryKnobs {
  final String dateTimeOfLastUpdate;
  final bool isMenuOnline;
  final OpeningHours openingHours;
  SksMenuHeaderStoryKnobs({required this.dateTimeOfLastUpdate, required this.isMenuOnline, required this.openingHours});
}

const meta = MetaWithArgs<SksMenuHeader, SksMenuHeaderStoryKnobs>();

final defaults = _Defaults(
  builder: (context, args) => SksMenuHeader(
    dateTimeOfLastUpdate: args.dateTimeOfLastUpdate,
    isMenuOnline: args.isMenuOnline,
    openingHours: args.openingHours,
  ),
);

final $default = SksMenuHeaderStory(args: SksMenuHeaderStoryKnobsArgs(openingHours: Arg.fixed(_mockOpeningHours)));
