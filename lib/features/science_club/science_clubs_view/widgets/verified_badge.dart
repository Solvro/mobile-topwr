import "package:flutter/material.dart";

import "../../../../theme/app_theme.dart";

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
    return SizedBox.square(
      dimension: 16,
      child: Padding(
        padding: const EdgeInsets.only(left: 4),
        child: Icon(
          Icons.verified_sharp,
          size: 12,
          color: context.colorTheme.orangePomegranade,
        ),
      ),
    );
  }
}
