import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../academic_calendar/model/academic_calendar_extensions.dart";
import "../../academic_calendar/model/academic_week_exception.dart";
import "../../academic_calendar/repository/academic_calendar_repo.dart";

/// A widget that controls visibility of a child widget based on academic calendar data.
///
/// Shows the child widget only when there is no academic calendar data available.
/// Otherwise, renders an empty [SizedBox].
///
/// This is used to show/hide the planner advertisement banner depending on whether
/// academic calendar information exists.
class PlannerBannerVisibility extends ConsumerWidget {
  const PlannerBannerVisibility({super.key, required this.child, this.reverseLogic = false});
  final Widget child;

  /// When [reverseLogic] is false (default), the [child] is shown only if there is no academic calendar data.
  /// When [reverseLogic] is true, the [child] is shown only if there is academic calendar data.
  final bool reverseLogic;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final academicCalendar = ref.watch(academicCalendarRepoProvider);
    return switch (academicCalendar) {
      AsyncData(:final AcademicCalendarWithSwaps? value) =>
        value == null || value.daySwaps.nextDaySwapsWithinWindow(value.windowDuration).isEmpty
            ? (reverseLogic ? const SizedBox.shrink() : child)
            : (reverseLogic ? child : const SizedBox.shrink()),
      _ => const SizedBox.shrink(),
    };
  }
}
