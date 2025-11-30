import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../../config/ui_config.dart";
import "../../../../../../theme/app_theme.dart";
import "../../../../../../utils/context_extensions.dart";
import "../../../../../../utils/ilist_nonempty.dart";
import "../../../../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../../../../widgets/horizontal_symmetric_safe_area.dart";
import "../../../../../../widgets/my_error_widget.dart";
import "../../../../presentation/widgets/accessibility_button.dart";
import "../../../../presentation/widgets/accessibility_profile_card.dart";
import "../../../../presentation/widgets/bullet_list.dart";
import "../../../../presentation/widgets/digital_guide_loading_view.dart";
import "../../business/railings_accessibility_comments_manager.dart";
import "../../data/models/railing.dart";
import "../../data/repository/railings_repository.dart";

@RoutePage()
class RailingsView extends ConsumerWidget {
  const RailingsView({required this.railingId});

  final int railingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncRailing = ref.watch(railingsRepositoryProvider(railingId));

    return asyncRailing.when(
      data: (data) => _RailingsView(railing: data),
      error: (error, stackTrace) {
        return HorizontalSymmetricSafeAreaScaffold(
          appBar: DetailViewAppBar(),
          body: MyErrorWidget(error, stackTrace: stackTrace),
        );
      },
      loading: () {
        return const DigitalGuideLoadingView();
      },
    );
  }
}

class _RailingsView extends ConsumerWidget {
  const _RailingsView({required this.railing});
  final Railing railing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return HorizontalSymmetricSafeAreaScaffold(
      appBar: DetailViewAppBar(actions: [AccessibilityButton()]),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DigitalGuideConfig.heightBig),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.localize.railing,
              style: context.textTheme.headline.copyWith(fontSize: DigitalGuideConfig.headlineFont),
            ),
            const SizedBox(height: DigitalGuideConfig.heightSmall),
            BulletList(
              items: [
                if (railing.translations.plTranslation.comment.isNotEmpty) railing.translations.plTranslation.comment,
                if (railing.railingHeight != null) context.localize.railing_height(railing.railingHeight!),
                context.localize.is_railing_on_landings(railing.isRailingOnLandings.toLowerCase()),
                if (railing.isTwoSidedRailing.toLowerCase() == "true") context.localize.is_two_sided_railing,
                context.localize.railing_type(railing.railingType),
                context.localize.is_round_cross_section_railing(railing.isRoundCrossSectionRailing.toLowerCase()),
                context.localize.is_railing_extended_30cm(railing.isRailingExtended30cm.toLowerCase()),
                context.localize.is_railing_obstacle(railing.isRailingObstacle.toLowerCase()),
              ].toIList(),
            ),
            const SizedBox(height: DigitalGuideConfig.heightBig),
            AccessibilityProfileCard(
              accessibilityCommentsManager: RailingsAccessibilityCommentsManager(
                railing: railing,
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
