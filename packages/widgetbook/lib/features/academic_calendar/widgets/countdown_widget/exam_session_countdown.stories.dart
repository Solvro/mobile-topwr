import "package:flutter/widgets.dart";
import "package:topwr/features/academic_calendar/repository/academic_calendar_repo.dart";
import "package:topwr/features/academic_calendar/widgets/countdown_widget/exam_session_countdown.dart";
import "package:widgetbook/widgetbook.dart";

import "../../../../widgetbook_mocks.dart";

part "exam_session_countdown.stories.g.dart";

const meta = Meta<ExamSessionCountdown>();

final $default = ExamSessionCountdownStory(
  args: ExamSessionCountdownArgs(academicCalendar: Arg.fixed(mockAcademicCalendarWithSwaps)),
);
