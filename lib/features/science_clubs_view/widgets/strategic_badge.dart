import "package:flutter/material.dart";

import "../../../theme/app_theme.dart";

class StrategicBadge extends WidgetSpan {
  const StrategicBadge()
      : super(
          baseline: TextBaseline.ideographic,
          alignment: PlaceholderAlignment.middle,
          child: const SizedBox.square(
            dimension: 16,
            child: _StrategicBadgeWidget(),
          ),
        );
}

class _StrategicBadgeWidget extends StatelessWidget {
  const _StrategicBadgeWidget();

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: "Koło strategiczne PWr",
      child: Stack(
        children: [
          Center(
            child: Icon(
              Icons.shield,
              size: 14,
              color: context.colorTheme.blueAzure,
            ),
          ),
          Align(
            alignment: const Alignment(0, -1 / 4),
            child: Text(
              context.localize.strategic_club_abbr,
              style: context.textTheme.bodyWhite.copyWith(fontSize: 6),
            ),
          ),
        ],
      ),
    );
  }
}
