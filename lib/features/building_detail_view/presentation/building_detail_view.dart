

import "package:auto_route/annotations.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

@RoutePage()
class BuildingDetailView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _BuildingDetailView();
  }

}

class _BuildingDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint("BuildingDetailView");
    return Scaffold(
      appBar: AppBar(
        title: const Text("AppBar"),
        actions: [],
      ),
      // appBar: DetailViewAppBar(
      //   title: const Text("fds"),
      // ),
      body: const Text("body"),
    );
  }
  
}
