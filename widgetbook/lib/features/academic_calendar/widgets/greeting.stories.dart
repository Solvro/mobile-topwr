import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:topwr/features/academic_calendar/model/academic_calendar.dart";
import "package:topwr/features/academic_calendar/model/day_swap_model.dart";
import "package:topwr/features/academic_calendar/model/weekday_enum.dart";
import "package:topwr/features/academic_calendar/repository/academic_calendar_repo.dart";
import "package:topwr/features/academic_calendar/widgets/home_screen_greeting.dart";
import "package:widgetbook/widgetbook.dart";

part "greeting.stories.g.dart";

final _mockCalendar = AcademicCalendar(
  id: 1,
  name: "Winter Semester 2024/2025",
  semesterStartDate: DateTime(2024, 10),
  examSessionStartDate: DateTime(2025, 2, 10),
  examSessionLastDate: DateTime(2025, 2, 28),
  isFirstWeekEven: false,
  createdAt: DateTime(2024, 9),
  updatedAt: DateTime(2024, 9),
);

final _mockDaySwaps = IList<DaySwapData>([
  DaySwapData(
    id: 1,
    academicCalendarId: 1,
    date: DateTime(2024, 10, 15),
    changedWeekday: WeekdayEnum.monday,
    changedDayIsEven: false,
    createdAt: DateTime(2024, 9),
    updatedAt: DateTime(2024, 9),
  ),
]);

final _mockAcademicCalendar = AcademicCalendarWithSwaps(calendarData: _mockCalendar, daySwaps: _mockDaySwaps);

const meta = Meta<Greeting>();

final $default = GreetingStory(args: GreetingArgs(academicCalendar: Arg.fixed(_mockAcademicCalendar)));
