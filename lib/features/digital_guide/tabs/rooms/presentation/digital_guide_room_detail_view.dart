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
import "../../../../navigator/utils/navigation_commands.dart";
import "../../../presentation/widgets/accessibility_button.dart";
import "../../../presentation/widgets/accessibility_profile_card.dart";
import "../../../presentation/widgets/bullet_list.dart";
import "../../../presentation/widgets/digital_guide_nav_link.dart";
import "../../../presentation/widgets/digital_guide_photo_row.dart";
import "../business/rooms_accessibility_comments_manager.dart";
import "../data/models/digital_guide_room.dart";
import "../platforms/presentation/room_platforms_content.dart";
import "../stairs/presentation/room_stairs_content.dart";

@RoutePage()
class DigitalGuideRoomDetailView extends ConsumerWidget {
  const DigitalGuideRoomDetailView({required this.room});

  final DigitalGuideRoom room;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomInformation = room.translations.pl;
    final widgets = [
      Text(roomInformation.name, style: context.textTheme.headline.copyWith(fontSize: 18)),
      const SizedBox(height: DigitalGuideConfig.heightTiny),
      Text(
        roomInformation.roomPurpose,
        style: context.textTheme.headline.copyWith(fontSize: 12, fontWeight: FontWeight.normal),
      ),
      if (roomInformation.workingDaysAndHours.isNotEmpty) const SizedBox(height: DigitalGuideConfig.heightMedium),
      if (roomInformation.workingDaysAndHours.isNotEmpty)
        Text("${context.localize.working_hours}:", style: context.textTheme.headline),
      if (roomInformation.workingDaysAndHours.isNotEmpty) const SizedBox(height: DigitalGuideConfig.heightSmall),
      Text(roomInformation.workingDaysAndHours, style: context.textTheme.body.copyWith(fontSize: 16)),
      if (roomInformation.workingDaysAndHours.isNotEmpty) const SizedBox(height: DigitalGuideConfig.heightMedium),
      Text(context.localize.key_information, style: context.textTheme.headline),
      const SizedBox(height: DigitalGuideConfig.heightSmall),
      BulletList(
        items: [
          roomInformation.location,
          roomInformation.comment,
          roomInformation.areEntrancesComment,
          roomInformation.isOneLevelFloorComment,
          roomInformation.arePlacesForWheelchairsComment,
        ].toIList(),
      ),
      AccessibilityProfileCard(
        accessibilityCommentsManager: RoomsAccessibilityCommentsManager(digitalGuideRoom: room, l10n: context.localize),
        backgroundColor: context.colorTheme.whiteSoap,
      ),
      if (room.imagesIds != null && room.imagesIds!.isNotEmpty) const SizedBox(height: DigitalGuideConfig.heightMedium),
      DigitalGuidePhotoRow(imagesIDs: room.imagesIds.toIList(), semanticsLabel: context.localize.room_information),
      const SizedBox(height: DigitalGuideConfig.heightMedium),
      ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return DigitalGuideNavLink(
            onTap: () async => ref.navigateDigitalGuideDoor(room.doors[index]),
            text: context.localize.door,
          );
        },
        itemCount: room.doors.length,
        separatorBuilder: (context, index) => const SizedBox(height: DigitalGuideConfig.heightMedium),
        shrinkWrap: true,
      ),
      const SizedBox(height: 2 * DigitalGuideConfig.heightMedium),
      if (room.roomStairs.isNotEmpty)
        ...room.roomStairs.asMap().entries.map((entry) {
          final String index = entry.key == 0 ? "" : (entry.key + 1).toString();
          return Padding(
            padding: const EdgeInsets.only(bottom: DigitalGuideConfig.paddingMedium),
            child: MyExpansionTile(
              title: "${context.localize.stairs} $index",
              children: [RoomStairsContent(roomStairsId: entry.value)],
            ),
          );
        }),
      if (room.platforms.isNotEmpty)
        ...room.platforms.asMap().entries.map((entry) {
          final String index = entry.key == 0 ? "" : (entry.key + 1).toString();
          return Padding(
            padding: const EdgeInsets.only(bottom: DigitalGuideConfig.paddingMedium),
            child: MyExpansionTile(
              title: "${context.localize.platforms} $index",
              children: [RoomPlatformsContent(platformId: entry.value)],
            ),
          );
        }),
    ];

    return HorizontalSymmetricSafeAreaScaffold(
      appBar: DetailViewAppBar(actions: [AccessibilityButton()]),
      body: Padding(
        padding: const EdgeInsets.all(DigitalGuideConfig.paddingBig),
        child: ListView.builder(
          itemCount: widgets.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => widgets[index],
        ),
      ),
    );
  }
}
