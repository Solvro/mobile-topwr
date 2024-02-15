import 'package:flutter/material.dart';

import '../../../../theme/app_theme.dart';

class DragHandleSection extends StatelessWidget {
  const DragHandleSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: _LineHandle(),
    );
  }
}

class _LineHandle extends StatelessWidget {
  const _LineHandle();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 4,
      decoration: BoxDecoration(
        color: context.colorTheme.blackMirage.withOpacity(0.16),
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}
