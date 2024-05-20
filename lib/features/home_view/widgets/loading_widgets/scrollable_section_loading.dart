import 'package:flutter/cupertino.dart';

import '../../../../widgets/loading_widgets/scrolable_loader_builder.dart';
import '../../../../widgets/loading_widgets/simple_previews/preview_card_loading.dart';
import '../paddings.dart';

class ScrollableSectionLoading extends StatelessWidget {
  const ScrollableSectionLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollableLoaderBuilder(
      mainAxisItemSize: 120,
      crossAxisForcedSize: 120,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return const MediumLeftPadding(
          child: PreviewCardLoading.square(size: 120),
        );
      },
    );
  }
}
