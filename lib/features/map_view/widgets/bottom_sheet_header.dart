import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/context_extensions.dart';
import 'drag_handle_section.dart';

class BottomSheetHeader extends StatelessWidget {
  const BottomSheetHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DragHandleSection(),
        Padding(
          padding: const EdgeInsets.only(
            left: 24,
            bottom: 16,
            right: 18,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.localize?.buildings_title ?? "",
                style: context.textTheme.headline,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  context.localize?.navigate ?? "",
                  style: context.textTheme.boldBodyOrange,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
