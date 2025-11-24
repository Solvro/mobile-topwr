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
import "../../../../presentation/widgets/digital_guide_nav_link.dart";
import "../../../../presentation/widgets/digital_guide_photo_row.dart";
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

    final textStrings = [
      comments.comment,
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
    ].map((e) => e.trim()).where((e) => e.isNotEmpty).toIList();

    final widgets = [
      Text(comments.name, style: context.textTheme.headline.copyWith(fontSize: DigitalGuideConfig.headlineFont)),
      const SizedBox(height: DigitalGuideConfig.heightMedium),
      BulletList(items: textStrings),
      AccessibilityProfileCard(
        accessibilityCommentsManager: CorridorsAccessibilityCommentsManager(l10n: context.localize, corridor: corridor),
        backgroundColor: context.colorTheme.whiteSoap,
      ),
      if (corridor.imagesIndices.isNotEmpty)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: DigitalGuideConfig.paddingMedium),
          child: DigitalGuidePhotoRow(imagesIDs: corridor.imagesIndices),
        ),
      if (corridor.doorsIndices.isNotEmpty) const SizedBox(height: DigitalGuideConfig.heightMedium),
      if (corridor.doorsIndices.isNotEmpty)
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: corridor.doorsIndices.length,
          separatorBuilder: (context, index) => const SizedBox(height: DigitalGuideConfig.heightMedium),
          itemBuilder: (context, index) => DigitalGuideNavLink(
            onTap: () => ref.navigateDigitalGuideDoor(corridor.doorsIndices[index]),
            text: context.localize.door,
          ),
        ),
    ];

    return Scaffold(
      appBar: DetailViewAppBar(actions: [AccessibilityButton()]),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DigitalGuideConfig.heightBig),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widgets.length,
          itemBuilder: (context, index) => widgets[index],
        ),
      ),
    );
  }
}
