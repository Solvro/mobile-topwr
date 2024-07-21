import 'package:flutter/material.dart';

import '../../../config/ui_config.dart';
import '../../../shared_repositories/departments_repository/departments_extra_params_ext.dart';
import '../../../shared_repositories/departments_repository/departments_repository.dart';
import '../../../api_base/directus_assets_url.dart';
import '../../../widgets/my_cached_image.dart';
import '../../../widgets/wide_tile_card.dart';

class DepartmentCard extends StatelessWidget {
  final Department department;
  const DepartmentCard(this.department, {super.key, this.onClick});
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    return WideTileCard(
      onTap: onClick,
      isActive: true,
      title: department.code,
      subtitle: department.name,
      activeShadows: null,
      activeGradient: department.gradient,
      trailing: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: SizedBox.square(
          dimension: WideTileCardConfig.imageSize,
          child: Opacity(
            opacity: .5,
            child: MyCachedImage(
              department.logo?.filename_disk.directusUrl,
              boxFit: BoxFit.contain,
              noShimmeringLoading: true,
            ),
          ),
        ),
      ),
    );
  }
}
