import "package:flutter/material.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";

class DigitalGuideNavLink extends StatelessWidget {
  const DigitalGuideNavLink({super.key, required this.onTap, required this.text});

  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
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
            Expanded(child: Text(text, style: context.textTheme.title, overflow: TextOverflow.ellipsis, maxLines: 3)),
            Icon(Icons.chevron_right, color: context.colorTheme.blueAzure),
          ],
        ),
      ),
    );
  }
}
