import 'package:flutter/material.dart';

import '../../../../widgets/loading_widgets/specific_imitations/wide_tile_loading.dart';
import '../../../config.dart';

class ResearchGroupLoading extends StatelessWidget {
  const ResearchGroupLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: ResearchGroupConfig.researchGroupTabGridDelegate,
      itemBuilder: (context, index) => const WideTileLoading(),
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
