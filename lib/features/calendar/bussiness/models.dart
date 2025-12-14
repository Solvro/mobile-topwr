import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "../../../theme/hex_color.dart";

typedef SingleCalendarItem = ({
  String name,
  String location,
  String hoursString,
  String? description,
  HexColor? accentColor,
});

typedef CalendarDayEvents = ({int day, IList<SingleCalendarItem> events, int weekday, bool isToday});

typedef CalendarMonthEvents = ({int month, IList<CalendarDayEvents> events});

typedef CalendarYearEvents = ({int year, IList<CalendarMonthEvents> events});
