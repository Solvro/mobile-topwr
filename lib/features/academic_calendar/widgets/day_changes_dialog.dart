import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../../utils/datetime_utils.dart";
import "../../digital_guide/tabs/accessibility_dialog/presentation/red_dialog.dart";
import "../model/academic_calendar_extensions.dart";
import "../model/academic_week_exception.dart";
import "../repository/academic_calendar_repo.dart";
import "../utils/localize_academic_day.dart";

class DayChangesDialog extends ConsumerWidget {
  const DayChangesDialog(this.calendar, {super.key, required this.windowDuration});

  final AcademicCalendar calendar;
  final Duration windowDuration;

  static Future<void> show(BuildContext context, AcademicCalendar calendar, Duration windowDuration) async {
    return showDialog<void>(
      context: context,
      builder: (context) => DayChangesDialog(calendar, windowDuration: windowDuration),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.localize;
    final exceptions = calendar.weeks.nextExceptionsWithinWindow(windowDuration);
    final calendarData = calendar.data;
    if (calendarData == null) {
      return const SizedBox.shrink();
    }
    return RedDialog(
      title: l10n.dayChangesDialogTitle,
      subtitle: l10n.dayChangesDialogSubtitle(windowDuration.inDays),
      applyButtonText: l10n.dayChangesDialogOk,
      showCloseButton: false,
      child: ListView.separated(
        padding: const EdgeInsets.all(32),
        shrinkWrap: true,
        itemCount: exceptions.length,
        separatorBuilder: (context, index) => const Divider(height: 24),
        itemBuilder: (context, index) {
          final change = exceptions[index];
          final changedAcademicDay = change.academicDay(calendarData);
          final standardAcademicDay = calendarData.standardAcademicDay(change.day);
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.swap_horiz, color: context.colorTheme.orangePomegranade, size: 32),
              const SizedBox(width: 16),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      change.day.toDayDateString(context, includeWeekday: false, includeYear: false),
                      style: context.textTheme.title.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: "${l10n.day_changes_dialog_will_be} "),
                          TextSpan(
                            text: changedAcademicDay.localize(context, includePrefix: false),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                " (${l10n.day_changes_dialog_instead_of} ${standardAcademicDay.localize(context, includePrefix: false)})",
                          ),
                        ],
                      ),
                      style: context.textTheme.body,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
