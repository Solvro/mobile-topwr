import "package:fl_chart/fl_chart.dart";
import "package:flutter/widgets.dart";

import "../../../theme/app_theme.dart";

extension WillMaxLabelOverlap on TitleMeta {
  bool get isMaxLabelOverlapping {
    return max % appliedInterval ~/ 10 == 0;
  }
}

class LeftLabels extends AxisTitles {
  LeftLabels(BuildContext context)
      : super(
          sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                if (value == meta.max && meta.isMaxLabelOverlapping) {
                  return const SizedBox.shrink();
                }
                return SideTitleWidget(
                  axisSide: AxisSide.left,
                  space: 10,
                  child: Text(
                    meta.formattedValue,
                    style: context.iParkingTheme.chart,
                  ),
                );
              },),
        );
}
