import "package:flutter/material.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../presentation/widgets/accessibility_profile_card.dart";
import "../../../presentation/widgets/bullet_list.dart";
import "../business/information_point_accessibility_manager.dart";
import "../models/digital_guide_information_points.dart";

class InformationPointWidget extends StatelessWidget {
  const InformationPointWidget({super.key, required this.data});

  final DigitalGuideInformationPoint data;

  @override
  Widget build(BuildContext context) {
    final l10n = context.localize;

    return Padding(
      padding: DigitalGuideConfig.symetricalPaddingBig,
      child: Column(
        children: [
          BulletList(items: data.getBulletList(l10n)),
          AccessibilityProfileCard(
            accessibilityCommentsManager: InformationPointAccessibilityManager(l10n: l10n, infoPoint: data),
          ),
        ],
      ),
    );
  }
}
