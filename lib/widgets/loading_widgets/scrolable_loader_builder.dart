import "package:flutter/material.dart";

class ScrollableLoaderBuilder extends StatelessWidget {
  const ScrollableLoaderBuilder({
    super.key,
    required this.itemBuilder,
    required this.mainAxisItemSize,
    required this.scrollDirection,
    this.crossAxisForcedSize,
    this.itemsSpacing = 0.0,
  });
  final Widget? Function(BuildContext, int) itemBuilder;

  final double mainAxisItemSize;

  final double? crossAxisForcedSize;

  final Axis scrollDirection;

  final double itemsSpacing;

  @override
  Widget build(BuildContext context) {
    final isHorizontal = scrollDirection == Axis.horizontal;
    final crossAxisSize = crossAxisForcedSize ?? double.infinity;
    return SizedBox(
      width: isHorizontal ? double.infinity : crossAxisSize,
      height: !isHorizontal ? double.infinity : crossAxisSize,
      child: ListView.builder(
        scrollDirection: scrollDirection,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          /// it's a workaround for ListView.separated, but without itemCount (infinite scrolling)
          /// for some reasons ListView.builder can be infinite, and ListView.separated not
          if (index.isEven) return itemBuilder(context, index ~/ 2);
          return _Gap(itemsSpacing);
        },
      ),
    );
  }
}

class _Gap extends SizedBox {
  const _Gap(double space) : super(height: space, width: space);
}
