import "package:flutter/material.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../widgets/loading_widgets/shimmer_loading.dart";
import "sks_menu_header.dart";
import "sks_menu_tiles.dart";

class SksMenuViewLoading extends StatelessWidget {
  const SksMenuViewLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorTheme.whiteSoap,
      body: Shimmer(
        linearGradient: shimmerGradient,
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            SksMenuHeaderLoading(),
            SksMenuTitleLoadingPaddings(),
          ],
        ),
      ),
    );
  }
}

class SksMenuTitleLoadingPaddings extends StatelessWidget {
  const SksMenuTitleLoadingPaddings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(SksMenuConfig.paddingLarge),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, _) {
          return const SksMenuTilesLoading();
        },
        separatorBuilder: (context, _) => const SizedBox(
          height: 8,
        ),
        itemCount: 3,
      ),
    );
  }
}
