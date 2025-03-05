import "package:auto_route/auto_route.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../../config/ui_config.dart";
import "../../../../../../theme/app_theme.dart";
import "../../../../../../utils/context_extensions.dart";
import "../../../../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../../../navigator/utils/navigation_commands.dart";
import "../../../../presentation/widgets/accessibility_button.dart";
import "../../../../presentation/widgets/accessibility_profile_card.dart";
import "../../../../presentation/widgets/bullet_list.dart";
import "../../../../presentation/widgets/digital_guide_image.dart";
import "../../../../presentation/widgets/digital_guide_nav_link.dart";
import "../../business/corridors_accessibility_comments_manager.dart";
import "../../data/models/corridor.dart";

@RoutePage()
class CorridorView extends ConsumerWidget {
  const CorridorView({required this.corridor});

  final Corridor corridor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.localize;
    final comments = corridor.translations.plTranslation;

    final textStrings =
        [
          corridor.translations.plTranslation.comment,
          "${l10n.corridor_simple_layout_text(corridor.isSimpleCorridorLayout.toLowerCase())} ${comments.isSimpleCorridorLayoutComment}",
          "${l10n.corridor_floor_marked(corridor.isFloorMarked.toLowerCase())} ${comments.isFloorMarkedComment}",
          "${l10n.corridor_room_entrances(corridor.areRoomsEntrances.toLowerCase())} ${comments.areRoomsEntrancesComment}",
          "${l10n.corridor_information_board(corridor.isInformationBoard.toLowerCase())} ${comments.isInformationBoardComment}",
          "${l10n.corridor_room_purpose_described_in_en(corridor.areRoomPurposeDescribedInEn.toLowerCase())} ${comments.areRoomPurposeDescribedInEnComment}",
          "${l10n.corridor_consistent_level_color_pattern(corridor.isConsistentLevelColorPattern.toLowerCase())} ${comments.isConsistentLevelColorPatternComment}",
          "${l10n.corridor_pictorial_directional_signs(corridor.arePictorialDirectionalSigns.toLowerCase())} ${comments.arePictorialDirectionalSignsComment}",
          "${l10n.corridor_seats(corridor.areSeats.toLowerCase())} ${comments.areSeatsComment}",
          "${l10n.corridor_vending_machines(corridor.areVendingMachines.toLowerCase())} ${comments.areVendingMachinesComment}",
          if (corridor.areVendingMachines.toLowerCase() == "true") comments.vendingMachinesProducts,
          "${l10n.corridor_emergency_plan(corridor.isEmergencyPlan.toLowerCase())} ${comments.isEmergencyPlanComment}",
        ].map((element) => element.trim()).where((element) => element.isNotEmpty).toIList();

    return Scaffold(
      appBar: DetailViewAppBar(actions: [AccessibilityButton()]),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DigitalGuideConfig.heightBig),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                Text(
                  corridor.translations.plTranslation.name,
                  style: context.textTheme.headline.copyWith(fontSize: DigitalGuideConfig.headlineFont),
                ),
                const SizedBox(height: DigitalGuideConfig.heightMedium),
                BulletList(items: textStrings),
                if (corridor.doorsIndices.isNotEmpty) const SizedBox(height: DigitalGuideConfig.heightMedium),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return DigitalGuideNavLink(
                      onTap: () async => ref.navigateDigitalGuideDoor(corridor.doorsIndices[index]),
                      text: context.localize.door,
                    );
                  },
                  itemCount: corridor.doorsIndices.length,
                  separatorBuilder: (context, index) => const SizedBox(height: DigitalGuideConfig.heightMedium),
                  shrinkWrap: true,
                ),
                const SizedBox(height: DigitalGuideConfig.heightMedium),
                if (corridor.imagesIndices.isNotEmpty)
                  Text(
                    context.localize.images,
                    style: context.textTheme.title.copyWith(fontSize: DigitalGuideConfig.headlineFont),
                  ),
              ]),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Padding(
                  padding: const EdgeInsets.all(DigitalGuideConfig.heightMedium),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(DigitalGuideConfig.borderRadiusSmall),
                    child: DigitalGuideImage(id: corridor.imagesIndices[index]),
                  ),
                );
              }, childCount: corridor.imagesIndices.length),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: DigitalGuideConfig.paddingBig),
                  child: AccessibilityProfileCard(
                    accessibilityCommentsManager: CorridorsAccessibilityCommentsManager(
                      l10n: context.localize,
                      corridor: corridor,
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
