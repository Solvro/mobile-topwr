import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SheetStickyHeader extends ConsumerWidget {
  const SheetStickyHeader({
    super.key,
    required this.header,
    required this.body,
    required this.scrollController,
  });

  final Widget header;
  final Widget body;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverAppBar(
          pinned: true,
          flexibleSpace: header,
        ),
        SliverToBoxAdapter(child: body),
      ],
    );
  }
}
