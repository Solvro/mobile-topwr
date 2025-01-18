import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../../config/ui_config.dart";
import "../../../../../../theme/app_theme.dart";
import "../../../../../../utils/context_extensions.dart";
import "../../../../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../../data/models/region.dart";

@RoutePage()
class RegionView extends ConsumerWidget {
  const RegionView({
    required this.region,
  });

  final Region region;

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
                  region.translations.plTranslation.name,
                  style: context.textTheme.headline.copyWith(fontSize: 22),
                ),
                const SizedBox(
                  height: DigitalGuideConfig.heightSmall,
                ),
                Text(
                  context.localize.region_location,
                  style: context.textTheme.boldBody.copyWith(fontSize: 16),
                ),
                const SizedBox(
                  height: DigitalGuideConfig.heightSmall,
                ),
                Text(
                  region.translations.plTranslation.location,
                  style: context.textTheme.body.copyWith(fontSize: 16),
                ),
                const SizedBox(
                  height: DigitalGuideConfig.heightMedium,
                ),
                // corridors
                // DigitalGuideNavLink(
                //   onTap: onTap,
                //   text: text
                // )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
