import "package:dotted_border/dotted_border.dart";
import "package:flutter/cupertino.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";

class SksChartLegend extends StatelessWidget {
  const SksChartLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: context.localize.sks_chart_legend_screen_reader_label,
      child: ExcludeSemantics(
        child: Column(
          children: [
            SksChartLegendItem(text: context.localize.measured_number_of_users, isPredicted: false),
            SksChartLegendItem(text: context.localize.forecasted_number_of_users, isPredicted: true),
          ],
        ),
      ),
    );
  }
}

class SksChartLegendItem extends StatelessWidget {
  const SksChartLegendItem({required this.text, required this.isPredicted});

  final String text;
  final bool isPredicted;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (isPredicted)
          DottedBorder(
            options: RectDottedBorderOptions(
              dashPattern: const [SksChartConfig.borderDashArray],
              color: context.colorScheme.secondary,
              padding: EdgeInsets.zero,
            ),
            child: Container(width: SksChartConfig.legendItemSize),
          )
        else
          Container(width: SksChartConfig.legendItemSize, height: 2, color: context.colorScheme.primary),
        const SizedBox(width: SksChartConfig.heightMedium),
        Expanded(
          child: Text(
            text,
            style: context.textTheme.bodyLarge,
            softWrap: true,
            textScaler: context.textScaler.clamp(maxScaleFactor: 1.5),
          ),
        ),
      ],
    );
  }
}
