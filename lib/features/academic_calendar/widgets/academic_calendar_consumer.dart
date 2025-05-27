import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/ui_config.dart";
import "../../../widgets/loading_widgets/simple_previews/horizontal_rectangular_section_loading.dart";
import "../../../widgets/my_error_widget.dart";
import "../repository/academic_calendar_repo.dart";
import "countdown_widget/exam_session_countdown.dart";
import "home_screen_greeting.dart";
import "incoming_day_changes.dart" show IncomingDayChanges;

class AcademicCalendarConsumer extends ConsumerWidget {
  const AcademicCalendarConsumer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(academicCalendarRepoProvider);

    return switch (state) {
      AsyncError(:final error, :final stackTrace) => Padding(
        padding: const EdgeInsets.only(top: HomeViewConfig.paddingSmall),
        child: MyErrorWidget(error, stackTrace: stackTrace),
      ),
      AsyncValue(:final AcademicCalendarWithSwaps value) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Greeting(value),
          const SizedBox(height: HomeViewConfig.paddingMedium),
          ExamSessionCountdown(value),
          const SizedBox(height: HomeViewConfig.paddingMedium / 1.5),
          IncomingDayChanges(calendar: value),
        ],
      ),
      _ => const Padding(
        padding: EdgeInsets.symmetric(horizontal: HomeViewConfig.paddingMedium),
        child: Column(
          children: [
            HorizontalRectangularSectionLoading(),
            SizedBox(height: HomeViewConfig.paddingMedium),
            HorizontalRectangularSectionLoading(),
          ],
        ),
      ),
    };
  }
}
