import "package:fast_immutable_collections/fast_immutable_collections.dart";

typedef SingleCalendarItem = ({String name, String location, String hoursString});

typedef CalendarDayEvents = ({int day, IList<SingleCalendarItem> events, int weekday});

typedef CalendarMonthEvents = ({int month, IList<CalendarDayEvents> events});

typedef CalendarYearEvents = ({int year, IList<CalendarMonthEvents> events});
