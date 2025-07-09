import "package:auto_route/auto_route.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../../navigator/utils/navigation_commands.dart";
import "../../../presentation/widgets/accessibility_button.dart";
import "../../../presentation/widgets/accessibility_profile_card.dart";
import "../../../presentation/widgets/bullet_list.dart";
import "../../../presentation/widgets/digital_guide_nav_link.dart";
import "../../../presentation/widgets/digital_guide_photo_row.dart";
import "../bussiness/entraces_accessibility_comments_manager.dart";
import "../data/models/digital_guide_entrace.dart";

@RoutePage()
class DigitalGuideEntranceDetailsView extends ConsumerWidget {
  const DigitalGuideEntranceDetailsView({required this.entrance});

  final DigitalGuideEntrace entrance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgets = [
      Text(entrance.translations.pl.name, style: context.textTheme.title.copyWith(fontSize: 24)),
      const SizedBox(height: DigitalGuideConfig.heightMedium),
      BulletList(
        items: [
          entrance.translations.pl.location,
          context.localize.entrance_is_main(entrance.isMain.toLowerCase()),
          //(thesun901): You might wonder what the hell is this? trust me, they are doing it this way on site this is so crazy tbh
          context.localize.entrance_is_accessible(
            entrance.isAccessible.isNotEmpty ? entrance.isAccessible.toLowerCase() : entrance.isMain.toLowerCase(),
          ),
          context.localize.entrance_is_for_personel(entrance.isForPersonel.toLowerCase()),
          context.localize.entrance_is_protection_from_weather(entrance.isProtectionFromWeather.toLowerCase()),
          context.localize.entrance_is_emergency_exit(entrance.isEmergencyExit.toLowerCase()),
          context.localize.entrance_is_building_marked_in_en(entrance.isBuildingMarkedInEn.toLowerCase()),
          context.localize.entrance_are_benches(entrance.areBenches.toLowerCase()),
          context.localize.entrance_number_of_doors(entrance.numberOfDoors),
        ].lock,
      ),
      const SizedBox(height: DigitalGuideConfig.heightSmall),
      AccessibilityProfileCard(
        backgroundColor: context.colorTheme.whiteSoap,
        accessibilityCommentsManager: EntrancesAccessibilityCommentsManager(
          digitalGuideEntrance: entrance,
          l10n: context.localize,
        ),
      ),
      const SizedBox(height: DigitalGuideConfig.heightBig),
      ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return DigitalGuideNavLink(
            onTap: () async => ref.navigateDigitalGuideDoor(entrance.doorsIndices[index]),
            text: context.localize.door,
          );
        },
        itemCount: entrance.doorsIndices.length,
        separatorBuilder: (context, index) => const SizedBox(height: DigitalGuideConfig.heightMedium),
        shrinkWrap: true,
      ),
      const SizedBox(height: DigitalGuideConfig.heightMedium),
      DigitalGuidePhotoRow(imagesIDs: entrance.imagesIndices, semanticsLabel: context.localize.entrances),
      const SizedBox(height: DigitalGuideConfig.heightMedium),
    ];

    return Scaffold(
      appBar: DetailViewAppBar(actions: [AccessibilityButton()]),
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
