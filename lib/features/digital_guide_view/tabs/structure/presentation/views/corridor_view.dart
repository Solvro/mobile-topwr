import "package:auto_route/auto_route.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../../config/ui_config.dart";
import "../../../../../../theme/app_theme.dart";
import "../../../../../../utils/context_extensions.dart";
import "../../../../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../../presentation/widgets/bullet_list.dart";
import "../../../../presentation/widgets/digital_guide_image.dart";
import "../../../../presentation/widgets/digital_guide_nav_link.dart";
import "../../../../presentation/widgets/digital_guide_photo_row.dart";
import "../../data/models/corridor.dart";

@RoutePage()
class CorridorView extends ConsumerWidget{
  const CorridorView({
    required this.corridor,
  });

  final Corridor corridor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: DetailViewAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: DigitalGuideConfig.heightBig,
        ),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                Text(corridor.translations.plTranslation.name, style: context.textTheme.headline.copyWith(fontSize: 22)),
                const SizedBox(height: DigitalGuideConfig.heightMedium),
                BulletList(
                  items: [
                    corridor.translations.plTranslation.comment,
                    if (corridor.isSimpleCorridorLayout) 
                      context.localize.corridor_simple_layout_text(corridor.translations.plTranslation.simpleCorridorLayoutComment) 
                    else context.localize.corridor_no_simple_layout_text(corridor.translations.plTranslation.simpleCorridorLayoutComment),
                    if (corridor.isFloorMarked) 
                      context.localize.floor_marked_text(corridor.translations.plTranslation.floorMarkedComment) 
                    else context.localize.floor_not_marked_text(corridor.translations.plTranslation.floorMarkedComment),
                    if (corridor.areRoomEntrances) 
                      context.localize.room_entrances_text(corridor.translations.plTranslation.roomEntrancesComment) 
                    else context.localize.no_room_entrances_text,
                    if (corridor.isInformationBoard) 
                      context.localize.information_board_text(corridor.translations.plTranslation.informationBoardComment) 
                    else context.localize.no_information_board_text(corridor.translations.plTranslation.informationBoardComment),
                    if(corridor.areRoomPurposeDescribedInEn) context.localize.room_puropose_described_in_en_text
                    else context.localize.room_puropose_not_described_in_en_text,
                    if(corridor.isConsistentLevelColorPattern) context.localize.room_puropose_described_in_en_text
                    else context.localize.not_consistent_level_color_pattern_text,
                    if(corridor.arePictorialdirectionalSigns) context.localize.pictorial_directional_signs_text(corridor.translations.plTranslation.pictorialDirectionalSignsComment)
                    else context.localize.no_pictorial_directional_signs_text(corridor.translations.plTranslation.pictorialDirectionalSignsComment),
                    if(corridor.areSeats) context.localize.seats_text(corridor.translations.plTranslation.seatsComment)
                    else context.localize.no_seats_text,
                    if(corridor.areVendingMachines) 
                      context.localize.vending_machines_text(corridor.translations.plTranslation.vendingMachinesComment),
                    if(corridor.areVendingMachines) corridor.translations.plTranslation.vendingMachinesProducts
                    else context.localize.no_vending_machines_text,
                    if(corridor.isEmergencyPlan) context.localize.emergency_plan_text
                    else context.localize.no_emergency_plan_text,
                  ].lock,
                ),
                const SizedBox(height: DigitalGuideConfig.heightBig),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return DigitalGuideNavLink(
                      onTap: () {},
                      text: context.localize.door,
                    );
                  },
                  itemCount: corridor.doorsIndices.length,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: DigitalGuideConfig.heightMedium,
                  ),
                  shrinkWrap: true,
                ),
                const SizedBox(height: DigitalGuideConfig.heightBig),
                if (corridor.imagesIndices.isNotEmpty)
                  Text(
                    context.localize.images,
                    style: context.textTheme.title.copyWith(fontSize: 22),
                  ),
              ]),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.all(DigitalGuideConfig.heightMedium),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        DigitalGuideConfig.borderRadiusSmall,
                      ),
                      child: DigitalGuideImage(
                        id: corridor.imagesIndices[index],
                      ),
                    ),
                  );
                },
                childCount: corridor.imagesIndices.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
