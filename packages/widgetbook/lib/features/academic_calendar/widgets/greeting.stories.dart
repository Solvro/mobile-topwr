import "package:flutter/widgets.dart";
import "package:topwr/features/academic_calendar/repository/academic_calendar_repo.dart";
import "package:topwr/features/academic_calendar/widgets/home_screen_greeting.dart";
import "package:widgetbook/widgetbook.dart";

import "../../../widgetbook_mocks.dart";

part "greeting.stories.g.dart";

const meta = Meta<Greeting>();

final $default = GreetingStory(args: GreetingArgs(academicCalendar: Arg.fixed(mockAcademicCalendarWithSwaps)));
