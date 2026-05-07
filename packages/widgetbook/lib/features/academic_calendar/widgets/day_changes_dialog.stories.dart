import "package:flutter/widgets.dart";
import "package:topwr/features/academic_calendar/repository/academic_calendar_repo.dart";
import "package:topwr/features/academic_calendar/widgets/day_changes_dialog.dart";
import "package:widgetbook/widgetbook.dart";

import "../../../widgetbook_mocks.dart";

part "day_changes_dialog.stories.g.dart";

const meta = Meta<DayChangesDialog>();

final $default = DayChangesDialogStory(args: DayChangesDialogArgs(calendar: Arg.fixed(mockAcademicCalendarWithSwaps)));
