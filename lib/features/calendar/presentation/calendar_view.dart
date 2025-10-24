import "dart:async";

import "package:auto_route/auto_route.dart";
import "package:collection/collection.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../../widgets/horizontal_symmetric_safe_area.dart";
import "../../../widgets/my_error_widget.dart";
import "../../../widgets/search_box_app_bar.dart";
import "../../analytics/data/umami.dart";
import "../../analytics/data/umami_events.dart";
import "../../departments/departments_view/widgets/departments_view_loading.dart";
import "../bussiness/get_events_per_days_use_case.dart";
import "../bussiness/models.dart";
import "../utils/calendar_view_extension.dart";
import "calendar_day_section.dart";
import "calendar_search_controller.dart";

@RoutePage()
class CalendarView extends ConsumerWidget {
  const CalendarView({super.key});

  static String localizedOfflineMessage(BuildContext context) {
    return context.localize.my_offline_error_message(context.localize.calendar);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return HorizontalSymmetricSafeAreaScaffold(
      appBar: SearchBoxAppBar(
        primary: true,
        addLeadingPopButton: true,
        context,
        title: context.localize.calendar,
        onQueryChanged: ref.watch(searchCalendarControllerProvider.notifier).onTextChanged,
        onSearchBoxTap: () {
          unawaited(ref.trackEvent(UmamiEvents.searchCalendar));
        },
      ),
      body: const _CalendarViewConsumer(),
    );
  }
}

class _CalendarViewConsumer extends ConsumerWidget {
  const _CalendarViewConsumer();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarList = ref.watch(getEventsPerDaysUseCaseProvider);

    return switch (calendarList) {
      AsyncError(:final error, :final stackTrace) => MyErrorWidget(error, stackTrace: stackTrace),
      AsyncValue(:final value) when value != null => _CalendarViewContent(calendarData: value),
      _ => const Padding(padding: GuideViewConfig.gridPadding, child: DepartmentsViewLoading()),
    };
  }
}

class _CalendarViewContent extends StatelessWidget {
  const _CalendarViewContent({required this.calendarData});

  final IList<CalendarYearEvents> calendarData;

  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year;
    final children = calendarData.map((year) {
      return year.events.map((month) {
        return [
          _MonthHeader(monthNumber: month.month, year: year.year != currentYear ? year.year : null),
          ...month.events.map((day) {
            return CalendarDaySection(day: day.day, events: day.events.toIList(), weekday: day.weekday);
          }),
        ];
      }).flattened;
    }).flattenedToList;
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: HomeViewConfig.paddingLarge),
      itemBuilder: (context, index) => children[index],
      itemCount: children.length,
    );
  }
}

class _MonthHeader extends StatelessWidget {
  const _MonthHeader({required this.monthNumber, this.year});
  final int monthNumber;
  final int? year;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: HomeViewConfig.paddingMedium, bottom: HomeViewConfig.paddingMedium),
      child: Text(
        monthNumber.monthToString(context) + (year != null ? " $year" : ""),
        style: context.textTheme.megaBigHeadline,
      ),
    );
  }
}
