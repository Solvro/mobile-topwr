import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

import "../../../../../../theme/app_theme.dart";
import "../../../../../config/ui_config.dart";
import "../../../../../utils/context_extensions.dart";
import "bullet_list.dart";

class AccessibilityProfileCard extends StatelessWidget {
  final IList<String> items;
  final String icon;

  const AccessibilityProfileCard({
    super.key,
    required this.items,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(DigitalGuideConfig.borderRadiusMedium),
            border: Border.all(
              color: context.colorTheme.blackMirage,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(DigitalGuideConfig.paddingMedium),
            child: BulletList(items: items),
          ),
        ),
        Positioned(
          top: -15,
          left: 20,
          child: ColoredBox(
            color: context.colorTheme.greyLight,
            child: Padding(
              padding: const EdgeInsets.all(DigitalGuideConfig.paddingSmall),
              child: Row(
                children: [
                  Text(
                    context.localize.accessibility_profile,
                    style: context.textTheme.title,
                  ),
                  const SizedBox(width: DigitalGuideConfig.heightSmall),
                  SvgPicture.asset(
                    icon,
                    height: 17,
                    width: 28,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
