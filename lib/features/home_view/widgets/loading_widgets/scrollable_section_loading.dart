import 'package:flutter/cupertino.dart';
import 'preview_card_loading.dart';

class ScrollableSectionLoading extends StatelessWidget {
  const ScrollableSectionLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: (MediaQuery.of(context).size.width ~/ 120) + 1,
          itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.only(right: 16),
              child: PreviewCardLoading(),
            );
          },
        )
    );
  }
}
