import "package:auto_route/auto_route.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../presentation/widgets/accessibility_button.dart";
import "../../../presentation/widgets/bullet_list.dart";
import "../../../presentation/widgets/digital_guide_image.dart";
import "../../../presentation/widgets/digital_guide_nav_link.dart";
import "../data/models/digital_guide_entrace.dart";

@RoutePage()
class DigitalGuideEntranceDetailsView extends ConsumerWidget {
  const DigitalGuideEntranceDetailsView({required this.entrance});

  final DigitalGuideEntrace entrance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Widget> widgets = [
      Text(
        entrance.translations.pl.name,
        style: context.textTheme.title.copyWith(fontSize: 24),
      ),
      const SizedBox(height: DigitalGuideConfig.heightMedium),
      BulletList(
        items: [
          if (entrance.isMain)
            "To wejście jest główne."
          else
            "To wejście nie jest główne",
          if (entrance.isAccessible)
            "To wejście jest dostępne."
          else
            "To wejście nie dostępne.",
          if (entrance.isForPersonel)
            "Wejście wymaga specjalnych uprawnień."
          else
            "Wejście nie wymaga specjalnych uprawnień.",
          entrance.translations.pl.location,
          entrance.translations.pl.comment,
          if (entrance.isEmergencyExit)
            "To jest wejście ewakuacyjne."
          else
            "Wejście nie wymaga specjalnych uprawnień.",
        ].lock,
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
        itemCount: entrance.doorsIndices.length,
        separatorBuilder: (context, index) => const SizedBox(
          height: DigitalGuideConfig.heightMedium,
        ),
        shrinkWrap: true,
      ),
      const SizedBox(height: DigitalGuideConfig.heightBig),
      if (entrance.imagesIndices.isNotEmpty)
        Text(
          context.localize.images,
          style: context.textTheme.title.copyWith(fontSize: 24),
        ),
    ];

    return Scaffold(
      appBar: DetailViewAppBar(
        actions: [AccessibilityButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: DigitalGuideConfig.heightBig,
        ),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => widgets[index],
                childCount: widgets.length,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.all(DigitalGuideConfig.heightMedium),
                    child: DigitalGuideImage(
                      id: entrance.imagesIndices[index],
                    ),
                  );
                },
                childCount: entrance.imagesIndices.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
