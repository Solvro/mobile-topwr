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
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: DigitalGuideConfig.paddingMedium),
        child: BulletList(
          items:
              [
                context.localize.entrance_is_main(entrance.isMain.toString()),
                context.localize.entrance_is_accessible(entrance.isAccessible.toString()),
                context.localize.entrance_is_for_personel(entrance.isForPersonel.toString()),
                context.localize.entrance_is_lit(entrance.isLit.toString()),
                context.localize.entrance_is_protection_from_weather(entrance.isProtectionFromWeather.toString()),
                context.localize.entrance_is_emergency_exit(entrance.isEmergencyExit.toString()),
                context.localize.entrance_is_building_marked_in_en(entrance.isBuildingMarkedInEn.toString()),
                context.localize.entrance_are_benches(entrance.areBenches.toString()),
              ].lock,
        ),
      ),
      const SizedBox(height: DigitalGuideConfig.heightBig),
      AccessibilityProfileCard(
        accessibilityCommentsManager: EntracesAccessibilityCommentsManager(
          digitalGuideEntrance: entrance,
          l10n: context.localize,
        ),
      ),
      AccessibilityProfileCard(
        accessibilityCommentsManager: EntracesAccessibilityCommentsManager(
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
      DigitalGuidePhotoRow(imagesIDs: entrance.imagesIndices),
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
