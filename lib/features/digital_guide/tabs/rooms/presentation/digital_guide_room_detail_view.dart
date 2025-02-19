import "package:auto_route/annotations.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../../utils/ilist_nonempty.dart";
import "../../../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../../../widgets/horizontal_symmetric_safe_area.dart";
import "../../../../../widgets/my_expansion_tile.dart";
import "../../../presentation/widgets/accessibility_button.dart";
import "../../../presentation/widgets/bullet_list.dart";
import "../../../presentation/widgets/digital_guide_nav_link.dart";
import "../../../presentation/widgets/digital_guide_photo_row.dart";
import "../data/models/digital_guide_room.dart";
import "../stairs/presentation/room_stairs_content.dart";

@RoutePage()
class DigitalGuideRoomDetailView extends ConsumerWidget {
  const DigitalGuideRoomDetailView({required this.room});

  final DigitalGuideRoom room;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomInformation = room.translations.pl;
    final widgets = [
      Text(
        roomInformation.name,
        style: context.textTheme.headline.copyWith(fontSize: 18),
      ),
      const SizedBox(height: DigitalGuideConfig.heightTiny),
      Text(
        roomInformation.roomPurpose,
        style: context.textTheme.headline
            .copyWith(fontSize: 12, fontWeight: FontWeight.normal),
      ),
      if (roomInformation.workingDaysAndHours.isNotEmpty)
        const SizedBox(height: DigitalGuideConfig.heightMedium),
      if (roomInformation.workingDaysAndHours.isNotEmpty)
        Text(
          "${context.localize.working_hours}:",
          style: context.textTheme.headline,
        ),
      if (roomInformation.workingDaysAndHours.isNotEmpty)
        const SizedBox(height: DigitalGuideConfig.heightSmall),
      Text(
        roomInformation.workingDaysAndHours,
        style: context.textTheme.body.copyWith(fontSize: 16),
      ),
      if (roomInformation.workingDaysAndHours.isNotEmpty)
        const SizedBox(height: DigitalGuideConfig.heightMedium),
      Text(
        context.localize.key_information,
        style: context.textTheme.headline,
      ),
      const SizedBox(height: DigitalGuideConfig.heightSmall),
      BulletList(
        items: [
          roomInformation.location,
          roomInformation.comment,
          roomInformation.areEntrancesComment,
          roomInformation.isOneLevelFloorComment,
          roomInformation.arePlacesForWheelchairsComment,
          roomInformation.isOneLevelFloorComment,
        ].toIList(),
      ),
      if (room.imagesIds != null && room.imagesIds!.isNotEmpty)
        const SizedBox(
          height: DigitalGuideConfig.heightMedium,
        ),
      DigitalGuidePhotoRow(imagesIDs: room.imagesIds.toIList()),
      const SizedBox(
        height: DigitalGuideConfig.heightMedium,
      ),
      DigitalGuideNavLink(
        onTap: () {},
        text: context.localize.door,
      ),
      const SizedBox(
        height: DigitalGuideConfig.heightMedium,
      ),
      DigitalGuideNavLink(
        onTap: () {},
        text: context.localize.platforms,
      ),
      const SizedBox(
        height: DigitalGuideConfig.heightMedium,
      ),
      if (room.roomStairs.isNotEmpty)
        MyExpansionTile(
          title: context.localize.stairs,
          children: [RoomStairsContent(roomStairsId: room.roomStairs[0])],
        ),
    ];
    return HorizontalSymmetricSafeAreaScaffold(
      appBar: DetailViewAppBar(
        actions: [AccessibilityButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(DigitalGuideConfig.paddingMedium),
        child: ListView.builder(
          itemCount: widgets.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => widgets[index],
        ),
      ),
    );
  }
}
