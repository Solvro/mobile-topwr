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
import "../../business/toilets_accessibility_comments_manager.dart";
import "../../data/models/toilet.dart";

@RoutePage()
class ToiletsView extends ConsumerWidget {
  const ToiletsView({required this.toilet});

  final Toilet toilet;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ToiletTranslation toiletsInformation = toilet.translations.plTranslation;

    return Scaffold(
      appBar: DetailViewAppBar(actions: [AccessibilityButton()]),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DigitalGuideConfig.paddingBig),
        child: ListView(
          children: [
            Text(
              toilet.toiletType == ToiletType.men ? context.localize.men_toilet : context.localize.women_toilet,
              style: context.textTheme.headline.copyWith(fontSize: DigitalGuideConfig.headlineFont),
            ),
            const SizedBox(height: DigitalGuideConfig.heightSmall),
            BulletList(
              items: [
                toiletsInformation.location,
                toiletsInformation.toiletDescription,
                toiletsInformation.numberOfCabins,
                "${context.localize.toilet_is_need_authorization(toilet.isNeedAuthorization.toLowerCase())} ${toiletsInformation.isNeedAuthorizationComment}",
                "${context.localize.toilet_are_clothes_hooks(toilet.areClothesHooks.toLowerCase())} ${toiletsInformation.areClothesHooksComment}",
                "${context.localize.toilet_is_wastebasket(toilet.isWastebasket.toLowerCase())} ${toiletsInformation.isWastebasketComment}",
                "${context.localize.toilet_is_hand_dryer(toilet.isHandDryer.toLowerCase())} ${toiletsInformation.isHandDryerComment}",
                "${context.localize.toilet_is_towel_dispenser(toilet.isTowelDispenser.toLowerCase())} ${toiletsInformation.isTowelDispenserComment}",
                "${context.localize.toilet_is_washbasin(toilet.isWashbasin.toLowerCase())} ${toiletsInformation.isWashbasinComment}",
                toiletsInformation.comment,
              ].toIList(),
            ),
            AccessibilityProfileCard(
              accessibilityCommentsManager: ToiletsAccessibilityCommentsManager(toilet: toilet, l10n: context.localize),
              backgroundColor: context.colorTheme.whiteSoap,
            ),
            ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: DigitalGuideConfig.paddingBig),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return DigitalGuideNavLink(
                  onTap: () => ref.navigateDigitalGuideDoor(toilet.doorsIds[index]),
                  text: context.localize.door,
                );
              },
              itemCount: toilet.doorsIds.length,
              separatorBuilder: (context, index) => const SizedBox(height: DigitalGuideConfig.heightMedium),
              shrinkWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
