import 'package:flutter/material.dart';

class ScrollableLoader extends StatelessWidget {
  const ScrollableLoader({
    super.key,
    required this.itemBuilder,
    required this.mainAxisItemSize,
    this.scrollDirection = Axis.horizontal,
    this.crossAxisForcedSize,
  });
  final Widget? Function(BuildContext, int) itemBuilder;

  final double mainAxisItemSize;

  final double? crossAxisForcedSize;

  final Axis scrollDirection;
  @override
  Widget build(BuildContext context) {
    final isHorizontal = scrollDirection == Axis.horizontal;
    final crossAxisSize = crossAxisForcedSize ?? double.infinity;

    return SizedBox(
        width: isHorizontal ? double.infinity : crossAxisSize,
        height: !isHorizontal ? double.infinity : crossAxisSize,
        child: LayoutBuilder(builder: (context, constraints) {
          final mainAxisAvailableSpace =
              isHorizontal ? constraints.maxWidth : constraints.maxWidth;

          final numberOfVisibleItems =
              (mainAxisAvailableSpace ~/ mainAxisItemSize) + 1;

          return ListView.builder(
            scrollDirection: scrollDirection,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: numberOfVisibleItems,
            itemBuilder: itemBuilder,
          );
        }));
  }
}
