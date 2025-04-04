import "package:flutter/cupertino.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../services/translations_service/widgets/text_with_translation.dart";
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWithTranslation(SksChartConfig.buildingCode, style: context.textTheme.headline),
            Text("${context.localize.street_abbreviation} ${SksChartConfig.sksAddress}", style: context.textTheme.body),
            TextWithTranslation(SksChartConfig.sksPostalCode, style: context.textTheme.body),
          ],
        ),
        Row(
          children: [
            Text(numberOfPeople, style: context.textTheme.body.copyWith(fontSize: 18)),
            const SizedBox(width: SksChartConfig.heightSmall),
            trend?.icon ?? const SizedBox.shrink(),
          ],
        ),
      ],
    );
  }
}
