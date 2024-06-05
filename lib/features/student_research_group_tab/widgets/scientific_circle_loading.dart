import 'package:flutter/material.dart';

import '../../../../widgets/loading_widgets/specific_imitations/wide_tile_loading.dart';
import '../../../config/ui_config.dart';

class ScientificCirclesLoading extends StatelessWidget {
  const ScientificCirclesLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: ScientificCirclesTabConfig.researchGroupTabGridDelegate,
      itemBuilder: (context, index) => const WideTileLoading(),
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
