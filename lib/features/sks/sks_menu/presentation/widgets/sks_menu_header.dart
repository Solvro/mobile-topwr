import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:protontime/protontime.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../../utils/datetime_utils.dart";
import "../../data/models/sks_opening_hours.dart";

class SksMenuHeader extends StatelessWidget {
  const SksMenuHeader({required this.dateTimeOfLastUpdate, required this.isMenuOnline, required this.openingHours});

  final String dateTimeOfLastUpdate;
  final bool isMenuOnline;
  final OpeningHours openingHours;
  @override
  Widget build(BuildContext context) {
    final stamp = DateTime.tryParse(dateTimeOfLastUpdate) ?? DateTime.now();
    return Semantics(
      container: true,
      explicitChildNodes: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: SksMenuConfig.paddingLarge),
          Text(
            context.localize.sks_menu,
            style: context.textTheme.headlineOrange.copyWith(fontSize: 28, height: 1),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: SksMenuConfig.paddingSmall),
            child: Text(
              DateTime.now().toDayDateString(context),
              textAlign: TextAlign.center,
              style: context.textTheme.title.copyWith(fontSize: 20, color: context.colorTheme.blueAzure, height: 1),
            ),
          ),
          MergeSemantics(
            child: Column(
              children: [
                Text(context.localize.working_hours, style: context.textTheme.body),
                Text(
                  "${context.localize.canteen} ${openingHours.canteen.openingTime} - ${openingHours.canteen.closingTime}",
                  style: context.textTheme.body,
                ),
                Text(
                  "${context.localize.cafe} ${openingHours.cafe.openingTime} - ${openingHours.cafe.closingTime}",
                  style: context.textTheme.body,
                ),
              ],
            ),
          ),
          if (isMenuOnline)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: SksMenuConfig.paddingSmall),
              child: Text(
                "${context.localize.last_modified}: ${Protontime.format(stamp, language: context.locale.languageCode)}",
                style: context.textTheme.bodyGrey,
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}
