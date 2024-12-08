import "package:flutter/material.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../widgets/loading_widgets/scrolable_loader_builder.dart";
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
      body: const Shimmer(
        linearGradient: shimmerGradient,
        child: Column(
          children: [
            SksMenuHeaderLoading(),
            Expanded(
              child: _SksMenuTitleLoadingPaddings(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SksMenuTitleLoadingPaddings extends StatelessWidget {
  const _SksMenuTitleLoadingPaddings();

  @override
  Widget build(BuildContext context) {
    return ScrollableLoaderBuilder(
      itemsSpacing: 4,
      mainAxisItemSize: 14,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: SksMenuConfig.paddingMedium),
          child: SksMenuTilesLoading(),
        );
      },
    );
  }
}
