import "package:flutter/material.dart";

import "../../../../../../theme/app_theme.dart";
import "../../../../../config/ui_config.dart";
import "../../../../../utils/context_extensions.dart";
import "package:flutter_svg/svg.dart";

class AccessibilityProfileCard extends StatelessWidget {
  final List<String> items;
  final String icon;

  const AccessibilityProfileCard(
      {super.key, required this.items, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(DigitalGuideConfig.paddingMedium),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(DigitalGuideConfig.paddingMedium),
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(DigitalGuideConfig.borderRadiusMedium),
              border: Border.all(
                color: context.colorTheme.blackMirage,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: DigitalGuideConfig.paddingSmall),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: items.map((item) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: DigitalGuideConfig.paddingSmall,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "\u2022",
                            style: context.textTheme.body,
                          ),
                          const SizedBox(
                            width: DigitalGuideConfig.paddingSmall,
                          ),
                          Expanded(
                            child: Text(
                              item,
                              style: context.textTheme.body,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Positioned(
            top: -15,
            left: 20,
            child: ColoredBox(
              color: context.colorTheme.greyLight,
              child: Padding(
                  padding:
                      const EdgeInsets.all(DigitalGuideConfig.paddingSmall),
                  child: Row(
                    children: [
                      Text(
                        context.localize.accessibility_profile,
                        style: context.textTheme.title,
                      ),
                      const SizedBox(
                        width: DigitalGuideConfig.paddingSmall,
                      ),
                      SvgPicture.asset(icon),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
