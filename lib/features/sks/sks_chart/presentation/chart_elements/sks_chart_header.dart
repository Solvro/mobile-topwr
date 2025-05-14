import "package:flutter/cupertino.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../sks_people_live/data/models/sks_user_data.dart";
import "../../../sks_people_live/presentation/widgets/sks_user_data_button.dart";

// TODO(mikolaj-jalocha): add navigation in separate button. Please see parking's chart.

class SksChartHeader extends StatelessWidget {
  const SksChartHeader({super.key, required this.numberOfPeople, required this.trend});

  final String numberOfPeople;
  final Trend? trend;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Semantics(
          label: context.localize.sks_chart_address_screen_reader_label,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                SksChartConfig.buildingCode,
                style: context.textTheme.headline,
                textScaler: MediaQuery.textScalerOf(context).clamp(maxScaleFactor: 1.5),
              ),
              Text(
                "${context.localize.street_abbreviation} ${SksChartConfig.sksAddress}",
                style: context.textTheme.body,
                textScaler: MediaQuery.textScalerOf(context).clamp(maxScaleFactor: 1.5),
              ),
              Text(
                SksChartConfig.sksPostalCode,
                style: context.textTheme.body,
                textScaler: MediaQuery.textScalerOf(context).clamp(maxScaleFactor: 1.5),
              ),
            ],
          ),
        ),
        Semantics(
          label:
              "${context.localize.sks_people_live_screen_reader_label} $numberOfPeople. ${context.localize.sks_people_live_screen_reader_label_trend} ${trend?.localizedName(context)}",
          child: ExcludeSemantics(
            child: Row(
              children: [
                Text(
                  numberOfPeople,
                  style: context.textTheme.body.copyWith(fontSize: 18),
                  textScaler: MediaQuery.textScalerOf(context).clamp(maxScaleFactor: 1.5),
                ),
                const SizedBox(width: SksChartConfig.heightSmall),
                trend?.icon ?? const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
