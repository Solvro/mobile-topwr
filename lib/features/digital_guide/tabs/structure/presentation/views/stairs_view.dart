import "package:auto_route/auto_route.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../../config/ui_config.dart";
import "../../../../../../theme/app_theme.dart";
import "../../../../../../utils/context_extensions.dart";
import "../../../../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../../../../widgets/horizontal_symmetric_safe_area.dart";
import "../../../../../../widgets/my_error_widget.dart";
import "../../../../../navigator/utils/navigation_commands.dart";
import "../../../../presentation/widgets/accessibility_button.dart";
import "../../../../presentation/widgets/accessibility_profile_card.dart";
import "../../../../presentation/widgets/bullet_list.dart";
import "../../../../presentation/widgets/digital_guide_loading_view.dart";
import "../../../../presentation/widgets/digital_guide_nav_link.dart";
import "../../business/stairs_accessibility_comments_manager.dart";
import "../../data/models/stairs.dart";
import "../../data/repository/stairs_repository.dart";

@RoutePage()
class StairsView extends ConsumerWidget {
  const StairsView({required this.stairsId});

  final int stairsId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncStairs = ref.watch(stairsRepositoryProvider(stairsId));

    return asyncStairs.when(
      loading: () {
        return const DigitalGuideLoadingView();
      },
      error: (error, stackTrace) {
        return HorizontalSymmetricSafeAreaScaffold(appBar: DetailViewAppBar(), body: MyErrorWidget(error));
      },
      data: (data) => _StairsView(stairs: data),
    );
  }
}

class _StairsView extends ConsumerWidget {
  const _StairsView({required this.stairs});
  final Stairs stairs;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final StairsTranslation stairsInformation = stairs.translations.plTranslation;
    return Scaffold(
      appBar: DetailViewAppBar(actions: [AccessibilityButton()]),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DigitalGuideConfig.heightBig),
        child: Column(
          children: [
            BulletList(
              items:
                  [
                    stairsInformation.location,
                    if (stairsInformation.stairsWidth.isNotEmpty)
                      "${context.localize.stairs_width} ${stairsInformation.stairsWidth}",
                    "${context.localize.stairs_are_emergency_stairs(stairsInformation.areEmergencyStairsComment.toLowerCase())} ${stairsInformation.areEmergencyStairsComment}",
                    if (stairsInformation.comment.isNotEmpty) stairsInformation.comment,
                  ].where((item) => item.trim().isNotEmpty).toIList(),
            ),
            const SizedBox(height: DigitalGuideConfig.heightBig),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return DigitalGuideNavLink(
                  onTap: () async => ref.navigateDigitalGuideRailing(stairs.railingsIDs[index]),
                  text: context.localize.railing,
                );
              },
              itemCount: stairs.railingsIDs.length,
              separatorBuilder: (context, index) => const SizedBox(height: DigitalGuideConfig.heightMedium),
              shrinkWrap: true,
            ),
            AccessibilityProfileCard(
              accessibilityCommentsManager: StairsAccessibilityCommentsManager(stairs: stairs, l10n: context.localize),
              backgroundColor: context.colorTheme.whiteSoap,
            ),
          ],
        ),
      ),
    );
  }
}
