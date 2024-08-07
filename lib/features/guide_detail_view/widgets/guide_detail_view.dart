

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../utils/context_extensions.dart";
import "../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../widgets/my_cached_image.dart";

class GuideDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: DetailViewAppBar(context, title: context.localize.guide),
       body: _GuideDetailDataView(),
    );

  }

}

class _GuideDetailDataView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
   // final state = ref.watch(IMPLEMENT PROVIDER);
    return ListView(
      children: [
       const MyCachedImage("",),
      ],
    );
  }
}