import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../../../widgets/my_cached_image.dart";
import "../../../../../widgets/my_point_widget.dart";
import "../../../presentation/widgets/digital_guide_nav_link.dart";
import "../data/models/adapted_toilet.dart";

@RoutePage()
class AdaptedToiletDetailView extends ConsumerWidget {
  const AdaptedToiletDetailView({
    required this.adaptedToilet,
  });

  final AdaptedToilet adaptedToilet;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: DetailViewAppBar(
        actions: const [],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: DigitalGuideConfig.heightBig,
        ),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                Text(
                  adaptedToilet.getDescription(context),
                  style: context.textTheme.title.copyWith(fontSize: 18),
                ),
                const SizedBox(
                  height: DigitalGuideConfig.heightMedium,
                ),
                if (adaptedToilet.translations.plTranslation.comment.isNotEmpty)
                  MyPointWidget(
                    text: adaptedToilet.translations.plTranslation.comment,
                  ),
                MyPointWidget(
                  text: adaptedToilet.translations.plTranslation.location,
                ),
                if (adaptedToilet
                    .translations.plTranslation.numberOfCabins.isNotEmpty)
                  MyPointWidget(
                    text:
                        adaptedToilet.translations.plTranslation.numberOfCabins,
                  ),
                MyPointWidget(
                  text: adaptedToilet
                      .translations.plTranslation.toiletDescription,
                ),
                if (!adaptedToilet.isAccessAccessibleForPwd)
                  MyPointWidget(
                    text: adaptedToilet.translations.plTranslation
                        .isAccessAccessibleForPwdComment,
                  ),
                if (adaptedToilet.isNeedAuthorization != "Unknown")
                  MyPointWidget(
                    text: adaptedToilet.isNeedAuthorization == "True"
                        ? context.localize.adapted_toilet_authorization(
                            adaptedToilet.translations.plTranslation
                                .isNeedAuthorizationComment,
                          )
                        : context.localize.adapted_toilet_no_authorization,
                  ),
                if (adaptedToilet.translations.plTranslation
                    .isAreaAllowingMovementInFrontEntranceComment.isNotEmpty)
                  MyPointWidget(
                    text: adaptedToilet.translations.plTranslation
                        .isAreaAllowingMovementInFrontEntranceComment,
                  ),
                MyPointWidget(
                  text: (adaptedToilet.isEntranceGraphicallyMarked &&
                          adaptedToilet.translations.plTranslation
                              .isEntranceGraphicallyMarkedComment.isNotEmpty)
                      ? context.localize.adapted_toilet_graphically_marked(
                          adaptedToilet.translations.plTranslation
                              .isEntranceGraphicallyMarkedComment,
                        )
                      : context.localize.adapted_toilet_not_graphically_marked,
                ),
                MyPointWidget(
                  text: adaptedToilet.isMarked
                      ? context.localize.adapted_toilet_is_marked(
                          adaptedToilet
                              .translations.plTranslation.isMarkedComment,
                        )
                      : context.localize.adapted_toilet_is_not_marked,
                ),
                const SizedBox(height: DigitalGuideConfig.heightBig),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return DigitalGuideNavLink(
                      onTap: () {},
                      text: context.localize.doors,
                    );
                  },
                  itemCount: adaptedToilet.doorsIndices.length,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: DigitalGuideConfig.heightMedium,
                  ),
                  shrinkWrap: true,
                ),
                const SizedBox(
                  height: DigitalGuideConfig.heightBig,
                ),
                if (adaptedToilet.imagesURLs.isNotEmpty)
                  Text(
                    context.localize.images,
                    style: context.textTheme.title.copyWith(fontSize: 28),
                  ),
                Column(
                  children: adaptedToilet.imagesURLs.map((imageURL) {
                    return Padding(
                      padding:
                          const EdgeInsets.all(DigitalGuideConfig.heightMedium),
                      child: MyCachedImage(imageURL),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: DigitalGuideConfig.heightBig,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
