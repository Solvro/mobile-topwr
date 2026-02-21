import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../analytics/data/clarity.dart";
import "../../../../analytics/data/clarity_events.dart";
import "../../../sks_chart/presentation/sks_chart_sheet.dart";
import "../../data/models/sks_user_data.dart";
import "../../data/repository/latest_sks_user_data_repo.dart";

class SksUserDataButton extends ConsumerWidget {
  const SksUserDataButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSksUserData = ref.watch(getLatestSksUserDataProvider);

    return asyncSksUserData.when(
      data: (sksUsersData) => _SksButton(
        sksUsersData,
        onTap: () async {
          unawaited(ref.trackEvent(ClarityEvents.openSksChart));
          await showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            constraints: const BoxConstraints(),
            builder: (BuildContext context) =>
                Semantics(explicitChildNodes: true, container: true, child: const SksChartSheet()),
          );
        },
      ),
      error: (error, stackTrace) => const SizedBox.shrink(),
      loading: () => const SizedBox.shrink(),
    );
  }
}

class _SksButton extends StatelessWidget {
  const _SksButton(this.sksUserData, {required this.onTap});

  final VoidCallback onTap;
  final SksUserData sksUserData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: SksConfig.outerPadding,
      child: Semantics(
        label:
            "${context.localize.sks_people_live_screen_reader_label} ${sksUserData.activeUsers}. ${context.localize.sks_people_live_screen_reader_label_trend} ${sksUserData.trend.localizedName(context)}",
        button: true,
        child: GestureDetector(
          onTap: onTap,
          child: ExcludeSemantics(
            child: Row(
              children: [
                Container(
                  padding: SksConfig.innerPadding,
                  decoration: BoxDecoration(
                    border: Border.all(color: context.colorScheme.primary),
                    borderRadius: BorderRadius.circular(SksConfig.radius),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.supervised_user_circle, color: context.colorScheme.primary),
                      const SizedBox(width: SksConfig.sizedBoxWidth),
                      Text(
                        sksUserData.activeUsers.toString(),
                        style: context.textTheme.titleLarge?.copyWith(color: context.colorScheme.primary),
                      ),
                      const SizedBox(width: SksConfig.sizedBoxWidth),
                      sksUserData.trend.icon,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension TrendIcon on Trend {
  Icon get icon {
    switch (this) {
      case Trend.increasing:
        return Icon(Icons.trending_up, color: Colors.grey.shade900);
      case Trend.decreasing:
        return Icon(Icons.trending_down, color: Colors.grey.shade900);
      case Trend.stable:
        return Icon(Icons.trending_flat, color: Colors.grey.shade900);
    }
  }

  String localizedName(BuildContext context) {
    switch (this) {
      case Trend.increasing:
        return context.localize.sks_people_live_screen_reader_label_trend_increasing;
      case Trend.decreasing:
        return context.localize.sks_people_live_screen_reader_label_trend_decreasing;
      case Trend.stable:
        return context.localize.sks_people_live_screen_reader_label_trend_stable;
    }
  }
}
