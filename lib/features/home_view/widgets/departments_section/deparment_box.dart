import 'package:flutter/material.dart';

import '../../../../api_base/directus_assets_url.dart';
import '../../../../config/ui_config.dart';
import '../../../../shared_repositories/departments_repository/departments_extra_params_ext.dart';
import '../../../../shared_repositories/departments_repository/departments_repository.dart';
import '../../../../theme/app_theme.dart';
import '../../../../widgets/my_cached_image.dart';
import '../../../../widgets/tile_splash.dart';

class DepartmentBox extends StatelessWidget {
  final Department department;
  final void Function() onClick;
  const DepartmentBox(this.department, {super.key, required this.onClick});

  @override
  Widget build(BuildContext context) {
    const size = 120.0;
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: department.gradient,
      ),
      child: Stack(
        children: [
          Center(
            child: Opacity(
              opacity: .4,
              child: SizedBox.square(
                dimension: 100,
                child: MyCachedImage(
                  department.logo?.filename_disk.directusUrl,
                  noShimmeringLoading: true,
                  boxFit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  department.code,
                  style: context.textTheme.titleWhite
                      .copyWith(shadows: HomeScreenConfig.squareCardTextShadow),
                ),
                Text(
                  department.name,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodyWhite,
                ),
              ],
            ),
          ),
          TileSplash(onTap: onClick),
        ],
      ),
    );
  }
}
