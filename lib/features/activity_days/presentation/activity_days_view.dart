import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../widgets/horizontal_symmetric_safe_area.dart";
import "widgets/activity_days_timetable.dart";

@RoutePage()
class ActivityDaysView extends HookConsumerWidget {
  const ActivityDaysView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.localize;
    final tabController = useTabController(initialLength: 3);

    return HorizontalSymmetricSafeAreaScaffold(
      appBar: DetailViewAppBar(title: (text: l10n.activity_days_title, context: context), leadingWidth: 100),
      body: Column(
        children: [
          Material(
            color: context.colorScheme.surface,
            child: TabBar(
              controller: tabController,
              labelColor: context.colorScheme.primary,
              unselectedLabelColor: context.colorScheme.onSurface.withValues(alpha: 0.6),
              indicatorColor: context.colorScheme.primary,
              dividerHeight: 1,
              dividerColor: context.colorScheme.outline.withValues(alpha: 0.2),
              tabs: [
                Tab(text: l10n.activity_days_tab_stands),
                Tab(text: l10n.activity_days_tab_timetable),
                Tab(text: l10n.activity_days_tab_info),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: const [_PlaceholderTab(), ActivityDaysTimetable(), _PlaceholderTab()],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlaceholderTab extends StatelessWidget {
  const _PlaceholderTab();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Coming soon",
        style: context.textTheme.bodyLarge?.copyWith(color: context.colorScheme.onSurface.withValues(alpha: 0.5)),
      ),
    );
  }
}
