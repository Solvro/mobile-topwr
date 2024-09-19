import "package:flutter/cupertino.dart";

import "../../../../config/ui_config.dart";
import "../../../../widgets/loading_widgets/scrolable_loader_builder.dart";
import "../../../../widgets/loading_widgets/specific_imitations/big_preview_card_loading.dart";
import "../paddings.dart";

class BigScrollableSectionLoading extends StatelessWidget {
  const BigScrollableSectionLoading({
    super.key,
    this.crossAxisForcedSize = BigPreviewCardConfig.defaultCrossAxisForcedSize,
  });

  final double crossAxisForcedSize;

  @override
  Widget build(BuildContext context) {
    return ScrollableLoaderBuilder(
      crossAxisForcedSize: crossAxisForcedSize,
      mainAxisItemSize: BigPreviewCardConfig.cardWidth,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return const MediumLeftPadding(
          child: BigPreviewCardLoading(),
        );
      },
    );
  }
}
