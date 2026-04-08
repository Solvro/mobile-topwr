import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:topwr/features/academic_calendar/model/academic_calendar.dart";
import "package:topwr/features/academic_calendar/model/day_swap_model.dart";
import "package:topwr/features/academic_calendar/model/weekday_enum.dart";
import "package:topwr/features/academic_calendar/repository/academic_calendar_repo.dart";
import "package:topwr/features/academic_calendar/widgets/incoming_day_changes.dart";
import "package:widgetbook/widgetbook.dart";

part "incoming_day_changes.stories.g.dart";

final _productionCalendar = AcademicCalendar(
  id: 2,
  name: "Semestr letni 2025/2026",
  semesterStartDate: DateTime(2026, 3, 2),
  examSessionStartDate: DateTime(2026, 6, 26),
  examSessionLastDate: DateTime(2026, 7, 14),
  isFirstWeekEven: false,
  createdAt: DateTime(2026, 2, 16, 12, 33, 38, 798),
  updatedAt: DateTime(2026, 2, 16, 12, 33, 38, 798),
);

final _productionDaySwaps = IList<DaySwapData>([
  // No production swaps in API, example placeholder:
  DaySwapData(
    id: 1,
    academicCalendarId: 2,
    date: DateTime(2026, 5, 15), // Example date, as in mock
    changedWeekday: WeekdayEnum.monday,
    changedDayIsEven: false,
    createdAt: DateTime(2026, 2, 16, 12, 33, 38, 798),
    updatedAt: DateTime(2026, 2, 16, 12, 33, 38, 798),
  ),
]);

final _productionAcademicCalendarWithSwaps = AcademicCalendarWithSwaps(
  calendarData: _productionCalendar,
  daySwaps: _productionDaySwaps,
);

const meta = Meta<IncomingDayChanges>();

final $default = IncomingDayChangesStory(
  args: IncomingDayChangesArgs(calendar: Arg.fixed(_productionAcademicCalendarWithSwaps)),
);
