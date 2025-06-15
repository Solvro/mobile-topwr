import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/cupertino.dart";

import "../../../config/ui_config.dart";
import "../../../utils/context_extensions.dart";
import "../../../widgets/search_not_found.dart";

class GuideGrid extends StatelessWidget {
  const GuideGrid({super.key, required this.children});

  final IList<Widget> children;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) {
      return SearchNotFound(message: context.localize.guide_not_found);
    }
    return GridView.builder(
      padding: GuideViewConfig.gridPadding,
      gridDelegate: DepartmentsConfig.departmentsViewGridDelegate(context),
      itemCount: children.length,
      itemBuilder: (context, index) => children[index],
    );
  }
}
