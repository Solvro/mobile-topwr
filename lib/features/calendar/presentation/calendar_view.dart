import "dart:async";

import "package:auto_route/auto_route.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_sticky_header/flutter_sticky_header.dart";

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
    final slivers = <Widget>[];

    for (final yearModel in calendarData) {
      for (final monthModel in yearModel.events) {
        final eventWidgets = monthModel.events
            .map(
              (dayModel) =>
                  CalendarDaySection(day: dayModel.day, events: dayModel.events.toIList(), weekday: dayModel.weekday),
            )
            .toList();

        final sliverMonthSection = SliverStickyHeader(
          header: _MonthHeader(monthNumber: monthModel.month, year: yearModel.year),
          sliver: SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: HomeViewConfig.paddingLarge,
              vertical: HomeViewConfig.paddingSmall,
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return eventWidgets[index];
              }, childCount: eventWidgets.length),
            ),
          ),
        );

        slivers.add(sliverMonthSection);
      }
    }

    return CustomScrollView(slivers: slivers);
  }
}

class _MonthHeader extends StatelessWidget {
  const _MonthHeader({required this.monthNumber, this.year});
  final int monthNumber;
  final int? year;
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colorTheme.whiteSoap,
      child: Padding(
        padding: const EdgeInsets.only(
          top: HomeViewConfig.paddingMedium,
          bottom: HomeViewConfig.paddingMedium,
          left: HomeViewConfig.paddingLarge,
        ),
        child: Text(
          monthNumber.monthToString(context) + (year != null ? " $year" : ""),
          style: context.textTheme.megaBigHeadline,
        ),
      ),
    );
  }
}
