import 'package:flutter/cupertino.dart';
import '../../../../config.dart';
import '../../../../widgets/big_preview_card_loading.dart';

class BigScrollableSectionLoading extends StatelessWidget {
  const BigScrollableSectionLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.maxFinite,
        height: 220,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: (MediaQuery.of(context).size.width ~/ BigPreviewCardConfig.cardWidth) + 1,
          itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.only(right: 16),
              child: BigPreviewCardLoading(),
            );
          },
        ));
  }
}