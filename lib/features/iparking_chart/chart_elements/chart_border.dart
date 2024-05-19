import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

class ChartBorder extends FlBorderData {
  ChartBorder(BuildContext context)
      : super(
          show: true,
          border: Border.all(
            color: context.colorTheme.greyPigeon,
            width: 0.5,
          ),
        );
}
