import 'package:flutter/cupertino.dart';

import '../../../../widgets/loading_widgets/preview_square_card_loading.dart';
import '../../../../widgets/loading_widgets/scrolable_loader.dart';
import '../paddings.dart';

class ScrollableSectionLoading extends StatelessWidget {
  const ScrollableSectionLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollableLoader(
      mainAxisItemSize: 120,
      crossAxisForcedSize: 120,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return const MediumLeftPadding(
          child: PreviewSquareCardLoading(size: 120),
        );
      },
    );
  }
}
