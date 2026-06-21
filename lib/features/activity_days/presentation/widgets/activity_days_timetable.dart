import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:intl/intl.dart";
import "package:sliver_tools/sliver_tools.dart";

import "../../../../config/ui_config.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../widgets/my_error_widget.dart";
import "../../../../widgets/search_not_found.dart";
import "../../../calendar/presentation/widgets/calendar_header_delegate.dart";
import "../../../calendar/presentation/widgets/calendar_tile.dart";
import "../../business/activity_days_timetable_use_case.dart";

class ActivityDaysTimetable extends ConsumerWidget {
  const ActivityDaysTimetable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timetable = ref.watch(activityDaysTimetableUseCaseProvider);

    return switch (timetable) {
      AsyncError(:final error, :final stackTrace) => MyErrorWidget(error, stackTrace: stackTrace),
      AsyncData(:final value) => _ActivityDaysTimetableContent(days: value),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }
}

class _ActivityDaysTimetableContent extends StatelessWidget {
  const _ActivityDaysTimetableContent({required this.days});

  final IList<TimetableDay> days;

  @override
  Widget build(BuildContext context) {
    if (days.isEmpty) {
      return SearchNotFound(message: context.localize.calendar_events_not_found);
    }

    final locale = Localizations.localeOf(context).languageCode;

    return CustomScrollView(
      slivers: days.map((day) {
        final label = DateFormat("EEEE, d MMMM", locale).format(day.date);
        return MultiSliver(
          pushPinnedChildren: true,
          children: [
            SliverPersistentHeader(
              pinned: true,
              delegate: CalendarHeaderDelegate(text: "${label[0].toUpperCase()}${label.substring(1)}"),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: HomeViewConfig.paddingLarge,
                vertical: HomeViewConfig.paddingSmall,
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: HomeViewConfig.paddingSmall),
                    child: CalendarTile(day.events[index]),
                  ),
                  childCount: day.events.length,
                ),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
