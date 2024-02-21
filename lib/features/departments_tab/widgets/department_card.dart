import 'package:flutter/material.dart';

import '../../../config.dart';
import '../../../theme/hex_color.dart';
import '../../../widgets/my_cached_image.dart';
import '../../../widgets/wide_tile_card.dart';
import '../repositories/departments_repository.dart';

class DepartmentCard extends StatelessWidget {
  final Department department;
  const DepartmentCard(this.department, {super.key});

  @override
  Widget build(BuildContext context) {
    final gradient = LinearGradient(
      colors: [
        HexColor(department.color?.gradientSecond ??
            DepartmentsConfig.defaultColorFirst),
        HexColor(department.color?.gradientFirst ??
            DepartmentsConfig.defaultColorSecond),
      ],
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
    );

    return WideTileCard(
      isActive: true,
      title: department.code,
      subtitle: department.name,
      activeShadows: null,
      activeGradient: gradient,
      trailing: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: SizedBox.square(
          dimension: WideTileCardConfig.imageSize,
          child: Opacity(
            opacity: .5,
            child: MyCachedImage(
              department.logo?.url,
              boxFit: BoxFit.contain,
              noShimmeringLoading: true,
            ),
          ),
        ),
      ),
    );
  }
}
