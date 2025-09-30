import "dart:async";

import "package:auto_route/auto_route.dart";
import "package:collection/collection.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/ui_config.dart";
import "../../../utils/context_extensions.dart";
import "../../../widgets/horizontal_symmetric_safe_area.dart";
import "../../../widgets/my_error_widget.dart";
import "../../../widgets/search_box_app_bar.dart";
import "../../../widgets/wide_tile_card.dart";
import "../../analytics/data/umami.dart";
import "../../analytics/data/umami_events.dart";
import "../../departments/departments_view/widgets/departments_view_loading.dart";
import "../data/model/calendar_data.dart";
import "../presentation/calendar_view_controller.dart";
import "../utils/calendar_view_extension.dart";

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
      body: const _CalendarViewContent(),
    );
  }
}

class _CalendarViewContent extends ConsumerWidget {
  const _CalendarViewContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarList = ref.watch(calendarListControllerProvider);

    return switch (calendarList) {
      AsyncError(:final error, :final stackTrace) => MyErrorWidget(error, stackTrace: stackTrace),
      AsyncValue(:final value) when value != null => Builder(
        builder: (context) {
          final groupedByYear = groupBy<CalendarData, int>(value, (e) => e.year);
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: HomeViewConfig.paddingLarge),
            children: groupedByYear.entries.map((year) {
              final groupedByMonth = groupBy<CalendarData, int>(year.value, (e) => e.month);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: HomeViewConfig.paddingMedium),
                    child: Text(
                      year.key.toString(),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ...groupedByMonth.entries.map((month) {
                    final groupedByDay = groupBy<CalendarData, int>(month.value, (e) => e.day);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: HomeViewConfig.paddingMedium),
                          child: Text(
                            month.key.monthToString(context),
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        ...groupedByDay.entries.map((day) {
                          final weekday = DateTime.parse(day.value.first.startTime).weekday;

                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 50,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      day.key.toString(),
                                      style: Theme.of(
                                        context,
                                      ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      WeekdayFormatter(weekday).weekdayToShort(context),
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: day.value
                                      .map(
                                        (event) => Padding(
                                          padding: const EdgeInsets.only(bottom: HomeViewConfig.paddingSmall),
                                          child: CalendarTile(event),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ],
                          );
                        }),
                      ],
                    );
                  }),
                ],
              );
            }).toList(),
          );
        },
      ),
      _ => const Padding(padding: GuideViewConfig.gridPadding, child: DepartmentsViewLoading()),
    };
  }
}

class CalendarTile extends ConsumerWidget {
  const CalendarTile(this.item, {super.key});
  final CalendarData item;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WideTileCard(
      title: item.name,
      subtitle: TimeRangeFormatter.getTimeRange(item.startTime, item.endTime),
      secondSubtitle: item.location,
      crossAxisAlignment: CrossAxisAlignment.stretch,
    );
  }
}
