import "package:auto_route/auto_route.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../../../../../../config/ui_config.dart";
import "../../../../../../theme/app_theme.dart";
import "../../../../../../utils/context_extensions.dart";
import "../../../../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../../presentation/widgets/accessibility_profile_card.dart";
import "../../../../presentation/widgets/bullet_list.dart";
import "../../data/bussiness/stairs_accessibility_comments_manager.dart";
import "../../data/models/stairs.dart";

@RoutePage()
class StairsView extends ConsumerWidget {
  const StairsView({required this.stairs});

  final Stairs stairs;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final StairsTranslation stairsInformation =
        stairs.translations.plTranslation;

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
                stairsInformation.location,
                if (stairsInformation.stairsWidth.isNotEmpty)
                  "${context.localize.stairs_width} ${stairsInformation.stairsWidth}",
                "${context.localize.stairs_are_emergency_stairs(stairsInformation.areEmergencyStairsComment.toLowerCase())} ${stairsInformation.areEmergencyStairsComment}",
                if (stairsInformation.comment.isNotEmpty)
                  stairsInformation.comment,
              ].where((item) => item.trim().isNotEmpty).toIList(),
            ),
            const SizedBox(
              height: DigitalGuideConfig.heightBig,
            ),
            AccessibilityProfileCard(
              accessibilityCommentsManager: StairsAccessibilityCommentsManager(
                stairs: stairs,
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
