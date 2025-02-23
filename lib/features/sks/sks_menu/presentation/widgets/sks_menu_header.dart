import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:protontime/protontime.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../../utils/datetime_utils.dart";
import "../../data/models/sks_opening_hours.dart";

class SksMenuHeader extends StatelessWidget {
  const SksMenuHeader({
    required this.dateTimeOfLastUpdate,
    required this.isMenuOnline,
    required this.openingHours,
  });

  final String dateTimeOfLastUpdate;
  final bool isMenuOnline;
  final OpeningHours openingHours;
  @override
  Widget build(BuildContext context) {
    final stamp = DateTime.tryParse(dateTimeOfLastUpdate) ?? DateTime.now();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: SksMenuConfig.paddingLarge),
        Text(
          context.localize.sks_menu,
          style: context.textTheme.headlineOrange
              .copyWith(fontSize: 28, height: 1),
        ),
        Padding(
          padding:
              const EdgeInsets.symmetric(vertical: SksMenuConfig.paddingSmall),
          child: Text(
            DateTime.now().toDayDateString(),
            style: context.textTheme.title.copyWith(
              fontSize: 20,
              color: context.colorTheme.blueAzure,
              height: 1,
            ),
          ),
        ),
        if (isMenuOnline)
          Text(
            "${context.localize.last_modified}: ${Protontime.format(
              stamp,
              language: "pl",
            )}",
            style: context.textTheme.bodyGrey,
          ),
        Padding(
          padding: const EdgeInsets.only(top: SksMenuConfig.paddingSmall),
          child: Text(
            context.localize.working_hours,
            style: context.textTheme.bodyGrey,
          ),
        ),
        Text(
          "${context.localize.canteen} ${openingHours.canteen.openingTime} - ${openingHours.canteen.closingTime}",
          style: context.textTheme.bodyGrey,
        ),
        Text(
          "${context.localize.cafe} ${openingHours.cafe.openingTime} - ${openingHours.cafe.closingTime}",
          style: context.textTheme.bodyGrey,
        ),
      ],
    );
  }
}
