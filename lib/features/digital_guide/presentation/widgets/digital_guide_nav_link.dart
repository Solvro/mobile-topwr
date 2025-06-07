import "package:flutter/material.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";

class DigitalGuideNavLink extends StatelessWidget {
  const DigitalGuideNavLink({super.key, required this.onTap, required this.text});

  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    final scaler = context.textScaler.clamp(maxScaleFactor: 2);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(DigitalGuideConfig.borderRadiusMedium),
      child: Ink(
        padding: DigitalGuideConfig.mediumButtonPadding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(DigitalGuideConfig.borderRadiusMedium),
          border: Border.all(color: context.colorTheme.greyPigeon),
          color: context.colorTheme.greyLight,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                text,
                textScaler: scaler,
                style: context.textTheme.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
            Icon(Icons.chevron_right, color: context.colorTheme.blueAzure),
          ],
        ),
      ),
    );
  }
}
