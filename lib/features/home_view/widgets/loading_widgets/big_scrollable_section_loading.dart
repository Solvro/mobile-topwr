import 'package:flutter/cupertino.dart';
import '../../../../config.dart';
import '../../../../widgets/loading_widgets/big_preview_card_loading.dart';
import '../paddings.dart';

class BigScrollableSectionLoading extends StatelessWidget {
  const BigScrollableSectionLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final numberOfVisibleItems = (MediaQuery.of(context).size.width ~/ BigPreviewCardConfig.cardWidth) + 1;

    return SizedBox(
        width: double.maxFinite,
        height: 220,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: numberOfVisibleItems,
          itemBuilder: (context, index) {
            return const MediumLeftPadding(
              child: BigPreviewCardLoading(),
            );
          },
        ));
  }
}