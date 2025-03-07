import "package:auto_route/auto_route.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../../../widgets/horizontal_symmetric_safe_area.dart";
import "../../../../navigator/utils/navigation_commands.dart";
import "../../../presentation/widgets/accessibility_button.dart";
import "../../../presentation/widgets/accessibility_profile_card.dart";
import "../../../presentation/widgets/bullet_list.dart";
import "../../../presentation/widgets/digital_guide_image.dart";
import "../../../presentation/widgets/digital_guide_nav_link.dart";
import "../business/adapted_toilet_accessibility_comments_menager.dart";
import "../data/models/adapted_toilet.dart";

@RoutePage()
class AdaptedToiletDetailView extends ConsumerWidget {
  const AdaptedToiletDetailView({required this.adaptedToilet});

  final AdaptedToilet adaptedToilet;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Widget> widgets = [
      Text(adaptedToilet.getDescription(context), style: context.textTheme.title.copyWith(fontSize: 24)),
      const SizedBox(height: DigitalGuideConfig.heightMedium),
      BulletList(
        items:
            [
              adaptedToilet.translations.plTranslation.comment,
              adaptedToilet.translations.plTranslation.location,
              adaptedToilet.translations.plTranslation.numberOfCabins,
              adaptedToilet.translations.plTranslation.toiletDescription,
              if (!adaptedToilet.isAccessAccessibleForPwd)
                adaptedToilet.translations.plTranslation.isAccessAccessibleForPwdComment,
              if (adaptedToilet.isNeedAuthorization != IsNeedAuthorizationEnum.unknown)
                adaptedToilet.isNeedAuthorization == IsNeedAuthorizationEnum.yes
                    ? context.localize.adapted_toilet_authorization(
                      adaptedToilet.translations.plTranslation.isNeedAuthorizationComment,
                    )
                    : context.localize.adapted_toilet_no_authorization,
              adaptedToilet.translations.plTranslation.isAreaAllowingMovementInFrontEntranceComment,
              if (adaptedToilet.isEntranceGraphicallyMarked)
                context.localize.adapted_toilet_graphically_marked(
                  adaptedToilet.translations.plTranslation.isEntranceGraphicallyMarkedComment,
                )
              else
                context.localize.adapted_toilet_not_graphically_marked,
              if (adaptedToilet.isMarked)
                context.localize.adapted_toilet_is_marked(adaptedToilet.translations.plTranslation.isMarkedComment)
              else
                context.localize.adapted_toilet_is_not_marked,
            ].lock,
      ),
      AccessibilityProfileCard(
        accessibilityCommentsManager: AdaptedToiletsAccessibilityCommentsManager(
          l10n: context.localize,
          adaptedToilet: adaptedToilet,
        ),
        backgroundColor: context.colorTheme.whiteSoap,
      ),
      if (adaptedToilet.doorsIndices.isNotEmpty) const SizedBox(height: DigitalGuideConfig.heightMedium),
      ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return DigitalGuideNavLink(
            onTap: () async => ref.navigateDigitalGuideDoor(adaptedToilet.doorsIndices[index]),
            text: context.localize.door,
          );
        },
        itemCount: adaptedToilet.doorsIndices.length,
        separatorBuilder: (context, index) => const SizedBox(height: DigitalGuideConfig.heightMedium),
        shrinkWrap: true,
      ),
      const SizedBox(height: DigitalGuideConfig.heightMedium),
      if (adaptedToilet.imagesIndices.isNotEmpty)
        Text(context.localize.images, style: context.textTheme.title.copyWith(fontSize: 22)),
    ];

    return HorizontalSymmetricSafeAreaScaffold(
      appBar: DetailViewAppBar(actions: [AccessibilityButton()]),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DigitalGuideConfig.heightBig),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) => widgets[index], childCount: widgets.length),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Padding(
                  padding: const EdgeInsets.all(DigitalGuideConfig.heightMedium),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(DigitalGuideConfig.borderRadiusSmall),
                    child: DigitalGuideImage(id: adaptedToilet.imagesIndices[index]),
                  ),
                );
              }, childCount: adaptedToilet.imagesIndices.length),
            ),
          ],
        ),
      ),
    );
  }
}
