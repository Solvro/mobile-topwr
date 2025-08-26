import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../../utils/datetime_utils.dart";
import "../../analytics/data/umami.dart";
import "../../analytics/data/umami_events.dart";
import "../../digital_guide/tabs/accessibility_dialog/presentation/red_dialog.dart";
import "../model/academic_calendar_extensions.dart";
import "../model/academic_week_exception.dart";
import "../repository/academic_calendar_repo.dart";
import "../utils/localize_academic_day.dart";

class DayChangesDialog extends ConsumerWidget {
  const DayChangesDialog(this.calendar, {super.key});

  final AcademicCalendarWithSwaps calendar;

  static Future<void> show(BuildContext context, AcademicCalendarWithSwaps calendar, WidgetRef ref) {
    unawaited(ref.trackEvent(UmamiEvents.openDaySwapAlertDialog));
    return showDialog<void>(context: context, builder: (context) => DayChangesDialog(calendar));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.localize;
    final swaps = calendar.daySwaps.nextDaySwapsWithinWindow(calendar.windowDuration(ref));
    final calendarData = calendar.data;
    return RedDialog(
      title: l10n.dayChangesDialogTitle,
      subtitle: l10n.dayChangesDialogSubtitle(calendar.windowDuration(ref)?.inDays ?? 7),
      applyButtonText: l10n.dayChangesDialogOk,
      showCloseButton: false,
      child: ListView.separated(
        padding: const EdgeInsets.all(32),
        shrinkWrap: true,
        itemCount: swaps.length,
        separatorBuilder: (context, index) => const Divider(height: HomeViewConfig.paddingLarge),
        itemBuilder: (context, index) {
          final swap = swaps[index];
          final swappedAcademicDay = swap.academicDay(calendarData);
          final standardAcademicDay = calendarData.standardAcademicDay(swap.date);
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
                      swap.date.toDayDateString(context, includeWeekday: false, includeYear: false),
                      style: context.textTheme.title.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: "${l10n.day_changes_dialog_will_be} "),
                          TextSpan(
                            text: swappedAcademicDay.localize(context, includePrefix: false),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                " (${l10n.day_changes_dialog_instead_of} ${standardAcademicDay.localize(context, includePrefix: false, getDeclinedNoun: true)})",
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
