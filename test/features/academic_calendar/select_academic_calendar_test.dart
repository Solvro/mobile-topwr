import "package:test/test.dart";
import "package:topwr/features/academic_calendar/model/academic_calendar.dart";
import "package:topwr/features/academic_calendar/model/day_swap_model.dart";
import "package:topwr/features/academic_calendar/model/weekday_enum.dart";
import "package:topwr/features/academic_calendar/utils/select_academic_calendar.dart";

void main() {
  final summer = _calendar(
    id: 1,
    name: "2025/2026 Lato",
    semesterStartDate: DateTime(2026, 3, 2),
    examSessionStartDate: DateTime(2026, 6, 26),
    examSessionLastDate: DateTime(2026, 7, 14),
  );
  final winter = _calendar(
    id: 2,
    name: "Zima 26/27",
    semesterStartDate: DateTime(2026, 10),
    examSessionStartDate: DateTime(2027, 2, 4),
    examSessionLastDate: DateTime(2027, 2, 22),
  );
  final calendars = [summer, winter];

  group("selectCurrentOrUpcoming", () {
    test("returns null for an empty list", () {
      expect(<AcademicCalendar>[].selectCurrentOrUpcoming(), isNull);
    });

    test("picks the upcoming winter semester after summer exams ended", () {
      expect(calendars.selectCurrentOrUpcoming(DateTime(2026, 9, 10))?.id, 2);
    });

    test("picks the current summer semester during classes", () {
      expect(calendars.selectCurrentOrUpcoming(DateTime(2026, 4, 15))?.id, 1);
    });

    test("picks the current summer semester during the exam session", () {
      expect(calendars.selectCurrentOrUpcoming(DateTime(2026, 7))?.id, 1);
    });

    test("picks the nearest upcoming semester when several are in the future", () {
      final nextSummer = _calendar(
        id: 3,
        name: "2026/2027 Lato",
        semesterStartDate: DateTime(2027, 3),
        examSessionStartDate: DateTime(2027, 6, 25),
        examSessionLastDate: DateTime(2027, 7, 13),
      );

      expect([winter, nextSummer].selectCurrentOrUpcoming(DateTime(2026, 9, 10))?.id, 2);
    });

    test("falls back to the most recently ended semester when all are expired", () {
      expect(calendars.selectCurrentOrUpcoming(DateTime(2027, 3))?.id, 2);
    });
  });

  group("hasCurrentOrUpcoming", () {
    test("is true when a later semester has not ended yet", () {
      expect(calendars.hasCurrentOrUpcoming(DateTime(2026, 9, 10)), isTrue);
    });

    test("is false when every semester has already ended", () {
      expect([summer].hasCurrentOrUpcoming(DateTime(2026, 9, 10)), isFalse);
    });
  });

  group("day swaps", () {
    final summerSwap = _daySwap(id: 1, academicCalendarId: 1, date: DateTime(2026, 4));
    final winterSwap = _daySwap(id: 31, academicCalendarId: 2, date: DateTime(2026, 11, 11));
    final swaps = [summerSwap, winterSwap];

    test("keeps only swaps for the selected calendar", () {
      expect(swaps.forAcademicCalendar(2).map((swap) => swap.id), [31]);
    });

    test("treats past-only swaps as stale cache", () {
      expect([summerSwap].hasUpcomingOrToday(DateTime(2026, 9, 10)), isFalse);
    });

    test("treats future swaps as a valid cache", () {
      expect(swaps.hasUpcomingOrToday(DateTime(2026, 9, 10)), isTrue);
    });
  });
}

AcademicCalendar _calendar({
  required int id,
  required String name,
  required DateTime semesterStartDate,
  required DateTime examSessionStartDate,
  required DateTime examSessionLastDate,
}) {
  return AcademicCalendar(
    id: id,
    name: name,
    semesterStartDate: semesterStartDate,
    examSessionStartDate: examSessionStartDate,
    examSessionLastDate: examSessionLastDate,
    isFirstWeekEven: false,
    createdAt: DateTime(2026),
    updatedAt: DateTime(2026),
  );
}

DaySwapData _daySwap({required int id, required int academicCalendarId, required DateTime date}) {
  return DaySwapData(
    id: id,
    academicCalendarId: academicCalendarId,
    date: date,
    changedWeekday: WeekdayEnum.monday,
    changedDayIsEven: true,
    createdAt: DateTime(2026),
    updatedAt: DateTime(2026),
  );
}
