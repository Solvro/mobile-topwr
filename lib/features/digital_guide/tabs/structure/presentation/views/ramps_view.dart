import "package:auto_route/auto_route.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../../config/ui_config.dart";
import "../../../../../../theme/app_theme.dart";
import "../../../../../../utils/context_extensions.dart";
import "../../../../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../../../navigator/utils/navigation_commands.dart";
import "../../../../presentation/widgets/accessibility_profile_card.dart";
import "../../../../presentation/widgets/bullet_list.dart";
import "../../../../presentation/widgets/digital_guide_nav_link.dart";
import "../../data/bussiness/ramps_accessibility_comments_manager.dart";
import "../../data/models/ramp.dart";

@RoutePage()
class RampsView extends ConsumerWidget {
  const RampsView({required this.ramps});

  final Ramp ramps;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final RampTranslation rampsInformation = ramps.translations.plTranslation;

    return Scaffold(
      appBar: DetailViewAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: DigitalGuideConfig.heightBig,
        ),
        child: Column(
          children: [
            BulletList(
              items: [
                rampsInformation.location,
                "${context.localize.ramps_width} ${ramps.rampWidth} cm.",
                context.localize.ramps_is_permanent_ramp(ramps.isPermanentRamp),
                if (rampsInformation.comment.isNotEmpty)
                  rampsInformation.comment,
              ].where((item) => item.trim().isNotEmpty).toIList(),
            ),
            const SizedBox(
              height: DigitalGuideConfig.heightBig,
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return DigitalGuideNavLink(
                  onTap: () async => ref.navigateDigitalGuideRailing(
                    ramps.railingsIDs[index],
                  ),
                  text: context.localize.railing,
                );
              },
              itemCount: ramps.railingsIDs.length,
              separatorBuilder: (context, index) => const SizedBox(
                height: DigitalGuideConfig.heightMedium,
              ),
              shrinkWrap: true,
            ),
            AccessibilityProfileCard(
              accessibilityCommentsManager: RampsAccessibilityCommentsManager(
                ramps: ramps,
                l10n: context.localize,
              ),
              backgroundColor: context.colorTheme.whiteSoap,
            ),
          ],
        ),
      ),
    );
  }
}
