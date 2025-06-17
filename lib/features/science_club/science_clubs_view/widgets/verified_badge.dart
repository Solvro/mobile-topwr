import "package:flutter/material.dart";

import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";

class VerifiedBadge extends WidgetSpan {
  const VerifiedBadge()
    : super(
        baseline: TextBaseline.ideographic,
        alignment: PlaceholderAlignment.middle,
        child: const _VerifiedBadgeWidget(),
      );
}

class _VerifiedBadgeWidget extends StatelessWidget {
  const _VerifiedBadgeWidget();

  @override
  Widget build(BuildContext context) {
    final scaler = context.textScaler.clamp(maxScaleFactor: 2);
    return Tooltip(
      message: context.localize.verifiedBySolvro,
      child: SizedBox.square(
        dimension: scaler.scale(16),
        child: Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Icon(
            Icons.verified_sharp,
            size: scaler.scale(12),
            color: context.colorTheme.orangePomegranade,
            semanticLabel: context.localize.verifiedBySolvro,
          ),
        ),
      ),
    );
  }
}
