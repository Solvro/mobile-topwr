import "package:dotted_border/dotted_border.dart";
import "package:flutter/cupertino.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";

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
            borderType: BorderType.RRect,
            dashPattern: const [SksChartConfig.borderDashArray],
            radius: const Radius.circular(SksChartConfig.borderRadius),
            padding: EdgeInsets.zero,
            // ignore: sized_box_for_whitespace
            child: Container(
              width: SksChartConfig.legendItemSize,
              height: SksChartConfig.legendItemSize,
            ),
          )
        else
          Container(
            width: SksChartConfig.legendItemSize,
            height: SksChartConfig.legendItemSize,
            decoration: BoxDecoration(
              color: context.colorTheme.orangePomegranade,
              borderRadius: const BorderRadius.all(
                Radius.circular(SksChartConfig.borderRadius),
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(left: SksChartConfig.paddingLarge),
          child: Text(
            text,
            style: context.textTheme.body,
          ),
        ),
      ],
    );
  }
}
