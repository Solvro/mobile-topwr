import "package:auto_route/auto_route.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../../../../../../config/ui_config.dart";
import "../../../../../../theme/app_theme.dart";
import "../../../../../../utils/context_extensions.dart";
import "../../../../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../../../navigator/utils/navigation_commands.dart";
import "../../../../presentation/widgets/accessibility_profile_card.dart";
import "../../../../presentation/widgets/bullet_list.dart";
import "../../../../presentation/widgets/digital_guide_nav_link.dart";
import "../../data/bussiness/toilets_accessibility_comments_manager.dart";
import "../../data/models/toilet.dart";

@RoutePage()
class ToiletsView extends ConsumerWidget {
  const ToiletsView({required this.toilet});

  final Toilet toilet;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ToiletTranslation toiletsInformation =
        toilet.translations.plTranslation;

    return Scaffold(
      appBar: DetailViewAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: DigitalGuideConfig.heightBig,
        ),
        child: ListView(
          children: [
            BulletList(
              items: [
                toiletsInformation.location,
                toiletsInformation.toiletDescription,
                toiletsInformation.numberOfCabins,
                "${context.localize.toilet_isNeedAuthorization(toilet.isNeedAuthorization.toLowerCase())} ${toiletsInformation.isNeedAuthorizationComment}",
                "${context.localize.toilet_areClothesHooks(toilet.areClothesHooks.toLowerCase())} ${toiletsInformation.areClothesHooksComment}",
                "${context.localize.toilet_isWastebasket(toilet.isWastebasket.toLowerCase())} ${toiletsInformation.isWastebasketComment}",
                "${context.localize.toilet_isHandDryer(toilet.isHandDryer.toLowerCase())} ${toiletsInformation.isHandDryerComment}",
                "${context.localize.toilet_isTowelDispenser(toilet.isTowelDispenser.toLowerCase())} ${toiletsInformation.isTowelDispenserComment}",
                "${context.localize.toilet_isWashbasin(toilet.isWashbasin.toLowerCase())} ${toiletsInformation.isWashbasinComment}",
                toiletsInformation.comment,
              ].where((item) => item.trim().isNotEmpty).toIList(),
            ),
            const SizedBox(
              height: DigitalGuideConfig.heightBig,
            ),
            // if (toilet.doorsIds.isNotEmpty)
            //   const SizedBox(height: DigitalGuideConfig.heightMedium),
            ListView.separated(
              padding: const EdgeInsets.symmetric(
                vertical: DigitalGuideConfig.heightBig,
              ),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return DigitalGuideNavLink(
                  onTap: () async => ref.navigateDigitalGuideDoor(
                    toilet.doorsIds[index],
                  ),
                  text: context.localize.door,
                );
              },
              itemCount: toilet.doorsIds.length,
              separatorBuilder: (context, index) => const SizedBox(
                height: DigitalGuideConfig.heightMedium,
              ),
              shrinkWrap: true,
            ),
            AccessibilityProfileCard(
              accessibilityCommentsManager: ToiletsAccessibilityCommentsManager(
                toilet: toilet,
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
