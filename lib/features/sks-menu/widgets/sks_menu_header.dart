import "package:flutter/cupertino.dart";

import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../../utils/datetime_utils.dart";

class SksMenuHeader extends StatelessWidget {
  const SksMenuHeader({
    required this.dateTimeOfLastUpdate,
    super.key,
  });

  final String dateTimeOfLastUpdate;

  @override
  Widget build(BuildContext context) {
    final int difference = DateTime.tryParse(dateTimeOfLastUpdate)
            ?.difference(DateTime.now())
            .inMinutes
            .abs() ??
        0;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          context.localize.sks_menu,
          style: context.textTheme.headlineOrange.copyWith(fontSize: 24),
        ),
        Padding(
          padding:
              const EdgeInsets.symmetric(vertical: SksMenuConfig.paddingSmall),
          child: Text(
            DateTime.now().toDayDateString(),
            style: context.textTheme.title
                .copyWith(fontSize: 18, color: context.colorTheme.blueAzure),
          ),
        ),
        Text(
          context.localize.relative_time(difference),
          style: context.textTheme.bodyGrey,
        ),
      ],
    );
  }
}
