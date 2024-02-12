import 'package:flutter/material.dart';

import 'bottom_sheet_header.dart';
import 'bottom_sheet_background.dart';

class BottomScrollSheet extends StatelessWidget {
  const BottomScrollSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      // key: _sheet,
      initialChildSize: 0.2,
      maxChildSize: 1,
      minChildSize: 0.2,
      expand: true,
      snap: true,
      snapSizes: const [0.5, 0.75],
      // /controller: _controller,
      builder: (BuildContext context, ScrollController scrollController) {
        return BottomSheetBackground(
          header: const BottomSheetHeader(),
          scrollableChild: ListView(
            controller: scrollController,
            children: [
              for (var i = 0; i < 100; i++)
                ListTile(
                  title: Text(i.toString()),
                ),
            ],
          ),
        );
      },
    );
  }
}
