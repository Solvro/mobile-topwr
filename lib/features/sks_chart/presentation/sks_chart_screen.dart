import "package:auto_route/annotations.dart";
import "package:dotted_border/dotted_border.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:fl_chart/fl_chart.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../theme/app_theme.dart";
import "../../../theme/colors.dart";
import "../../../utils/context_extensions.dart";
import "../../../utils/datetime_utils.dart";
import "../../bottom_scroll_sheet/drag_handle.dart";
import "../data/models/sks_chart_data.dart";
import "../data/repository/sks_chart_repository.dart";


@RoutePage()
class SksChartView extends ConsumerWidget {
  const SksChartView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncChartData = ref.watch(getLatestChartDataProvider);
    final maxNumberOfUsers = asyncChartData.value?.maxNumberOfUsers ?? 0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 16),
            child: Center(child: LineHandle()),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 12,
              right: 12,
              top: 12,
            ),
            child: Center(
              child: Text(
                context.localize.sks_chart_title,
                style: context.textTheme.headline,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 50,
              left: 25,
            ),
            child: _SksChart(
              maxNumberOfUsers: maxNumberOfUsers,
              asyncChartData: asyncChartData,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _LegendItem(
                text: context.localize.sks_chart_legend_users,
                isPredicted: false,
              ),
              _LegendItem(
                text: context.localize.sks_chart_legend_forecast,
                isPredicted: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SksChart extends StatelessWidget {
  const _SksChart({
    required this.maxNumberOfUsers,
    required this.asyncChartData,
  });

  final double maxNumberOfUsers;
  final AsyncValue<IList<SksChartData>> asyncChartData;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: BarChart(
        swapAnimationDuration: Duration.zero,
        BarChartData(
          backgroundColor: context.colorTheme.whiteSoap,
          gridData: const FlGridData(
            drawHorizontalLine: false,
            drawVerticalLine: false,
          ),
          maxY: maxNumberOfUsers + (maxNumberOfUsers / 10).toInt(),
          borderData: FlBorderData(
            show: false,
          ),
          barGroups: asyncChartData.value
              ?.asMap()
              .entries
              .map<BarChartGroupData>((entry) {
            final int index = entry.key;
            final data = entry.value;
            final isPredicted =
                data.externalTimestamp.isAfter(DateTime.now()) ||
                    (data.externalTimestamp.isAtSameMomentAs(DateTime.now()) &&
                        data.activeUsers == 0);
            return _makeSksChartBar(
              x: index,
              y: isPredicted ? data.movingAverage21 : data.activeUsers,
              isPredicted: isPredicted,
            );
          }).toList(),
          alignment: BarChartAlignment.spaceAround,
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(),
            leftTitles: const AxisTitles(),
            rightTitles: AxisTitles(
              axisNameWidget: Text(
                context.localize.sks_chart_number_of_users,
                style: context.textTheme.body
                    .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              axisNameSize: 35,
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 25,
                getTitlesWidget: (double value, TitleMeta meta) {
                  return Text(
                    "${value.toInt()}",
                    style: context.textTheme.body
                        .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 35,
                getTitlesWidget: (double value, TitleMeta meta) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      style: context.textTheme.body
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                      asyncChartData.value![value.toInt()].externalTimestamp
                          .toLocal()
                          .toHourMinuteString(),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.text, required this.isPredicted});

  final String text;
  final bool isPredicted;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (isPredicted)
          DottedBorder(
            borderType: BorderType.RRect,
            dashPattern: const [4],
            radius: const Radius.circular(8),
            padding: EdgeInsets.zero,
            // ignore: sized_box_for_whitespace
            child: Container(
              width: 18,
              height: 18,
            ),
          )
        else
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: context.colorTheme.orangePomegranade,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            text,
            style: context.textTheme.body,
          ),
        ),
      ],
    );
  }
}

BarChartGroupData _makeSksChartBar({
  required int x,
  required int y,
  bool isPredicted = false,
}) {
  return BarChartGroupData(
    x: x,
    barRods: [
      BarChartRodData(
        width: 15,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
        toY: y.toDouble(),
        color:
            isPredicted ? Colors.transparent : ColorsConsts.orangePomegranade,
        borderDashArray: isPredicted ? [4] : null,
        borderSide: isPredicted ? const BorderSide() : null,
      ),
    ],
  );
}
