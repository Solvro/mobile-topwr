import 'package:flutter/material.dart';

import '../../../../widgets/loading_widgets/specific_imitations/wide_tile_loading.dart';
import '../../../config.dart';

class DepartmentsListLoading extends StatelessWidget {
  const DepartmentsListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: DepartmentsConfig.departmentsTabGridDelegate,
      itemBuilder: (context, index) => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: WideTileLoading(),
      ),
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
