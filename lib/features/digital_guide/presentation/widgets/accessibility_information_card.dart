import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../../widgets/my_html_widget.dart";
import "../../../../utils/context_extensions.dart";

class AccessibilityInformationCard extends StatelessWidget {
  final Color color;
  final String icon;
  final String text;

  const AccessibilityInformationCard({super.key, required this.color, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final isHTML = text.contains("<span style=");
    final scaler = context.textScaler.clamp(minScaleFactor: 0.5, maxScaleFactor: 2);

    return Container(
      constraints: const BoxConstraints(
        minHeight:
            DigitalGuideConfig.paddingMedium +
            DigitalGuideConfig
                .difficultiesCardIconSize, // so basically if the comment is HTML, we allow it to be much longer (makes sense e.g. in Polinka case)
        // if it's not HTML, we limit it to 2 lines, so the minHeight = height in such case
      ),
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(64), offset: const Offset(0, 4), blurRadius: 4)],
        border: Border(left: BorderSide(color: color, width: 10)),
        borderRadius: BorderRadius.circular(DigitalGuideConfig.borderRadiusMedium),
        color: context.colorTheme.whiteSoap,
      ),
      child: Row(
        children: [
          Padding(
            padding: DigitalGuideConfig.widePaddingMedium,
            child: Container(
              width: scaler.scale(DigitalGuideConfig.difficultiesCardIconSize),
              height: scaler.scale(DigitalGuideConfig.difficultiesCardIconSize),
              decoration: BoxDecoration(
                border: Border.all(color: color),
                borderRadius: BorderRadius.circular(DigitalGuideConfig.borderRadiusSmall),
                color: context.colorTheme.whiteSoap,
              ),
              child: Center(
                child: Builder(
                  builder: (context) {
                    final size = scaler.scale(20);
                    return SizedBox.square(
                      dimension: size,
                      child: ExcludeSemantics(
                        child: SvgPicture.asset(icon, height: size, width: size),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(width: DigitalGuideConfig.heightTiny),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: DigitalGuideConfig.paddingSmall),
              child: isHTML
                  ? Padding(
                      padding: const EdgeInsets.all(DigitalGuideConfig.heightSmall),
                      child: MyHtmlWidget(
                        text,
                        textStyle: context.textTheme.body.copyWith(height: DigitalGuideConfig.accessibleLineHeight),
                      ),
                    )
                  : Text(
                      text,
                      style: context.textTheme.body.copyWith(height: DigitalGuideConfig.accessibleLineHeight),
                      overflow: TextOverflow.ellipsis,
                      maxLines: context.textScaler.clamp(minScaleFactor: 1).scale(2).toInt(),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
