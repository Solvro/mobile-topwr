import "package:flutter/material.dart";

import "../../../../../widgets/loading_widgets/specific_imitations/wide_tile_loading.dart";
import "../../../../config/ui_config.dart";

class DepartmentsViewLoading extends StatelessWidget {
  const DepartmentsViewLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: DepartmentsConfig.departmentsViewGridDelegate,
      itemBuilder: (context, index) => const WideTileLoading(),
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
