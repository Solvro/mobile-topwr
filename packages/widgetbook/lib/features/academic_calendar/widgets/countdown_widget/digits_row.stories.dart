import "package:flutter/widgets.dart";
import "package:topwr/features/academic_calendar/repository/academic_calendar_repo.dart";
import "package:topwr/features/academic_calendar/widgets/countdown_widget/digits_widgets.dart";
import "package:widgetbook/widgetbook.dart";

import "../../../../widgetbook_mocks.dart";

part "digits_row.stories.g.dart";

const meta = Meta<DigitsRow>();

final $default = DigitsRowStory(args: DigitsRowArgs(calendarData: Arg.fixed(mockAcademicCalendarWithSwaps)));
