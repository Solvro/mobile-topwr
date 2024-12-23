import "package:flutter/material.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";

class DigitalGuideNavLink extends StatelessWidget {
  const DigitalGuideNavLink({
    super.key,
    required this.onTap,
    required this.text,
  });

  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: DigitalGuideConfig.mediumButtonPadding,
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(DigitalGuideConfig.borderRadiusMedium),
          border: Border.all(
            color: DigitalGuideConfig.borderColor,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: context.textTheme.body,
              overflow: TextOverflow.ellipsis,
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: context.colorTheme.blueAzure,
            ),
          ],
        ),
      ),
    );
  }
}
