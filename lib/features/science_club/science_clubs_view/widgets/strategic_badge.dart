import "package:flutter/material.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "strategic_club_badges.icons.dart";

class StrategicBadge extends WidgetSpan {
  const StrategicBadge()
    : super(
        baseline: TextBaseline.ideographic,
        alignment: PlaceholderAlignment.middle,
        child: const _StrategicBadgeWidget(),
      );
}

class _StrategicBadgeWidget extends StatelessWidget {
  const _StrategicBadgeWidget();

  @override
  Widget build(BuildContext context) {
    final isPolish = context.solvroLocale == SolvroLocale.pl;
    final scaler = context.textScaler;
    return Tooltip(
      message: context.localize.strategicBadgeTooltip,
      child: Padding(
        padding: const EdgeInsets.only(left: 4),
        child: Icon(
          isPolish ? StrategicClubBadges.polish_badge : StrategicClubBadges.english_badge,
          size: scaler.scale(14),
          color: context.colorTheme.blueAzure,
        ),
      ),
    );
  }
}
