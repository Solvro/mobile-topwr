import "package:flutter/cupertino.dart";

import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";

class GuideGrid extends StatelessWidget {
  const GuideGrid({super.key, required this.children});
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) {
      return Center(
        child: Text(
          context.localize.guide_not_found,
          style: context.textTheme.body,
        ),
      );
    }
    return GridView.builder(
      padding: GuideViewConfig.gridPadding,
      gridDelegate: DepartmentsConfig.departmentsViewGridDelegate,
      itemCount: children.length,
      itemBuilder: (context, index) => children[index],
    );
  }
}
