import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../../config/ui_config.dart";
import "../../../../../../theme/app_theme.dart";
import "../../../../../../utils/context_extensions.dart";
import "../../../../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../../../../widgets/horizontal_symmetric_safe_area.dart";
import "../../../../presentation/widgets/accessibility_button.dart";
import "../../../../presentation/widgets/accessibility_profile_card.dart";
import "../../../../presentation/widgets/bullet_list.dart";
import "../../../information_points/business/information_point_accessibility_manager.dart";
import "../../../information_points/models/digital_guide_information_points.dart";

@RoutePage()
class InformationPointView extends ConsumerWidget {
  const InformationPointView({required this.informationPoint, super.key});

  final DigitalGuideInformationPoint informationPoint;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.localize;

    return HorizontalSymmetricSafeAreaScaffold(
      appBar: DetailViewAppBar(actions: [AccessibilityButton()]),
      body: Padding(
        padding: DigitalGuideConfig.symetricalPaddingBig,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Focus(
              autofocus: true,
              child: Text(
                l10n.information_point,
                style: context.textTheme.headlineMedium?.copyWith(fontSize: DigitalGuideConfig.headlineFont),
              ),
            ),
            const SizedBox(height: DigitalGuideConfig.heightSmall),
            BulletList(items: informationPoint.getBulletList(l10n)),
            const SizedBox(height: DigitalGuideConfig.heightSmall),
            AccessibilityProfileCard(
              accessibilityCommentsManager: InformationPointAccessibilityManager(
                l10n: l10n,
                infoPoint: informationPoint,
              ),
              backgroundColor: context.colorScheme.surface,
            ),
          ],
        ),
      ),
    );
  }
}
