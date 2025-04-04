import "package:flutter/material.dart";

import "../../../../config/ui_config.dart";
import "../../../../services/translations_service/widgets/text_with_translation.dart";
import "../../../../theme/app_theme.dart";
import "../../../../widgets/my_cached_image.dart";
import "../../../../widgets/optimized_directus_image.dart";
import "../../../../widgets/tile_splash.dart";
import "../../../departments/departments_view/repository/departments_extensions.dart";
import "../../../departments/departments_view/repository/departments_repository.dart";

class DepartmentHomeTile extends StatelessWidget {
  final Department department;
  final VoidCallback onClick;
  const DepartmentHomeTile(this.department, {super.key, required this.onClick});

  @override
  Widget build(BuildContext context) {
    final code = department.code.toLowerCase();
    final useSpecialOpacity = code == "w3";
    final logoOpacity = useSpecialOpacity ? .22 : .15;

    const size = 120.0;
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), gradient: department.gradient),
      child: Stack(
        children: [
          Center(
            child: Opacity(
              opacity: logoOpacity,
              child: SizedBox.square(
                dimension: 100,
                child: OptimizedDirectusImage(
                  department.logo?.filename_disk,
                  loadingType: LoadingType.noLoading,
                  boxFit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWithTranslation(
                  department.code,
                  style: context.textTheme.titleWhite.copyWith(shadows: HomeViewConfig.squareCardTextShadow),
                ),
                TextWithTranslation(
                  department.name,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodyWhite.copyWith(shadows: HomeViewConfig.squareCardTextShadow),
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
