import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:topwr/features/academic_calendar/model/academic_calendar.dart";
import "package:topwr/features/academic_calendar/repository/academic_calendar_repo.dart";
import "package:topwr/features/academic_calendar/widgets/countdown_widget/exam_session_countdown.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: ExamSessionCountdown)
Widget useCaseExamSessionCountdown(BuildContext context) {
  return ExamSessionCountdown(
    AcademicCalendarWithSwaps(
      calendarData: AcademicCalendar(
        id: 1,
        name: "Test",
        semesterStartDate: DateTime.now(),
        examSessionStartDate: DateTime.now(),
        examSessionLastDate: DateTime.now(),
        isFirstWeekEven: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      daySwaps: IList(const []),
    ),
  );
}
