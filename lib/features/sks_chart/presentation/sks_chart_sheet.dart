import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../bottom_scroll_sheet/drag_handle.dart";
import "../data/models/sks_chart_data.dart";
import "../data/repository/sks_chart_repository.dart";
import "chart_elements/sks_chart_legend_item.dart";
import "sks_chart.dart";

class SksChartSheet extends ConsumerWidget {
  const SksChartSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncChartData = ref.watch(getLatestChartDataProvider);
    final maxNumberOfUsers = asyncChartData.value?.maxNumberOfUsers ?? 0;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: SksChartConfig.paddingExtraSmall,
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(SksChartConfig.paddingLarge),
            child: _SksSheetHeader(),
          ),
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 50,
                    left: 25,
                  ),
                  child: SksChart(
                    maxNumberOfUsers: maxNumberOfUsers,
                    asyncChartData: asyncChartData,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SksChartLegendItem(
                      text: context.localize.sks_chart_legend_users,
                      isPredicted: false,
                    ),
                    SksChartLegendItem(
                      text: context.localize.sks_chart_legend_forecast,
                      isPredicted: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SksSheetHeader extends StatelessWidget {
  const _SksSheetHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const LineHandle(),
        const SizedBox(height: 8),
        Text(
          context.localize.sks_chart_title,
          style: context.textTheme.headline
              .copyWith(color: context.colorTheme.blueAzure),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
