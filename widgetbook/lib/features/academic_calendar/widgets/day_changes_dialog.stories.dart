import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:topwr/features/academic_calendar/model/academic_calendar.dart";
import "package:topwr/features/academic_calendar/model/day_swap_model.dart";
import "package:topwr/features/academic_calendar/model/weekday_enum.dart";
import "package:topwr/features/academic_calendar/repository/academic_calendar_repo.dart";
import "package:topwr/features/academic_calendar/widgets/day_changes_dialog.dart";
import "package:topwr/utils/datetime_utils.dart";
import "package:widgetbook/widgetbook.dart";

part "day_changes_dialog.stories.g.dart";

/// Dates relative to [today] so `IList.nextDaySwapsWithinWindow` (next 7 days) is
/// non-empty; fixed 2024 dates were always in the past and produced an empty list.
final AcademicCalendarWithSwaps _mockAcademicCalendar = () {
  final t = today;
  final calendar = AcademicCalendar(
    id: 1,
    name: "Winter Semester 2024/2025",
    semesterStartDate: t.subtract(const Duration(days: 45)),
    examSessionStartDate: t.add(const Duration(days: 120)),
    examSessionLastDate: t.add(const Duration(days: 150)),
    isFirstWeekEven: false,
    createdAt: t.subtract(const Duration(days: 60)),
    updatedAt: t.subtract(const Duration(days: 60)),
  );

  final daySwaps = IList<DaySwapData>([
    DaySwapData(
      id: 1,
      academicCalendarId: 1,
      date: t.add(const Duration(days: 2)),
      changedWeekday: WeekdayEnum.wednesday,
      changedDayIsEven: true,
      createdAt: t,
      updatedAt: t,
    ),
    DaySwapData(
      id: 2,
      academicCalendarId: 1,
      date: t.add(const Duration(days: 4)),
      changedWeekday: WeekdayEnum.monday,
      changedDayIsEven: false,
      createdAt: t,
      updatedAt: t,
    ),
    DaySwapData(
      id: 3,
      academicCalendarId: 1,
      date: t.add(const Duration(days: 6)),
      changedWeekday: WeekdayEnum.friday,
      changedDayIsEven: true,
      createdAt: t,
      updatedAt: t,
    ),
  ]);

  return AcademicCalendarWithSwaps(calendarData: calendar, daySwaps: daySwaps);
}();

const meta = Meta<DayChangesDialog>();

final $default = DayChangesDialogStory(args: DayChangesDialogArgs(calendar: Arg.fixed(_mockAcademicCalendar)));
