import 'package:flutter/cupertino.dart';

import '../../../../config.dart';
import '../../../../widgets/loading_widgets/big_preview_card_loading.dart';
import '../../../../widgets/loading_widgets/scrolable_loader.dart';
import '../paddings.dart';

class BigScrollableSectionLoading extends StatelessWidget {
  const BigScrollableSectionLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScrollableLoader(
      crossAxisForcedSize: 220,
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
