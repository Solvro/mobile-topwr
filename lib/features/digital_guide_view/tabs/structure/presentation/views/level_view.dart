import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../../config/ui_config.dart";
import "../../../../../../theme/app_theme.dart";
import "../../../../../../utils/context_extensions.dart";
import "../../../../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../../../navigator/utils/navigation_commands.dart";
import "../../../../data/models/level_with_regions.dart";
import "../../../../presentation/widgets/digital_guide_nav_link.dart";

@RoutePage()
class LevelView extends ConsumerWidget {
  const LevelView({
    required this.levelInfo,
  });
  final LevelWithRegions levelInfo;

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
                Text(
                  levelInfo.level.translations.plTranslation.name,
                  style: context.textTheme.headline
                      .copyWith(fontSize: DigitalGuideConfig.headlineFont),
                ),
                const SizedBox(
                  height: DigitalGuideConfig.heightSmall,
                ),
                Text(
                  context.localize.rooms_distribution,
                  style: context.textTheme.boldBody
                      .copyWith(fontSize: DigitalGuideConfig.bodyFont),
                ),
                const SizedBox(
                  height: DigitalGuideConfig.heightSmall,
                ),
                Text(
                  levelInfo.level.translations.plTranslation.roomNumbersRange,
                  style: context.textTheme.body
                      .copyWith(fontSize: DigitalGuideConfig.bodyFont),
                ),
                const SizedBox(
                  height: DigitalGuideConfig.heightMedium,
                ),
              ]),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Column(
                  children: [
                    DigitalGuideNavLink(
                      onTap: () async {
                        await ref.navigateDigitalGuideRegion(
                          levelInfo.level,
                          levelInfo.regions[index],
                        );
                      },
                      text: levelInfo
                          .regions[index].translations.plTranslation.name,
                    ),
                    const SizedBox(
                      height: DigitalGuideConfig.heightMedium,
                    ),
                  ],
                ),
                childCount: levelInfo.regions.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
