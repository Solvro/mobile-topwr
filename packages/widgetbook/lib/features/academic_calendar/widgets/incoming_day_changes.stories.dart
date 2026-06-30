import "package:flutter/widgets.dart";
import "package:topwr/features/academic_calendar/repository/academic_calendar_repo.dart";
import "package:topwr/features/academic_calendar/widgets/incoming_day_changes.dart";
import "package:widgetbook/widgetbook.dart";

import "../../../widgetbook_mocks.dart";

part "incoming_day_changes.stories.g.dart";

const meta = Meta(IncomingDayChanges.new);

final $default = IncomingDayChangesStory(
  args: IncomingDayChangesArgs(calendar: Arg.fixed(mockAcademicCalendarWithSwaps)),
);
