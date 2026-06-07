import "dart:async";

import "package:flutter/material.dart";

import "../../../../config/ui_config.dart";
import "../../../../services/haptics/app_haptics.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../widgets/my_cached_image.dart";
import "../../../../widgets/wide_tile_card.dart";
import "../../../branches/data/model/branch.dart";
import "../data/models/department.dart";
import "../data/utils/departments_extensions.dart";

class DepartmentCard extends StatelessWidget {
  final Department department;
  const DepartmentCard(this.department, {super.key, this.onClick});
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Theme(
      data: context.defaultThemeWithOverrideTextStyles(
        titleLarge: textTheme.titleLarge?.copyWith(shadows: HomeViewConfig.squareCardTextShadow),
        bodyLarge: textTheme.bodyLarge?.copyWith(shadows: HomeViewConfig.squareCardTextShadow),
      ),
      child: WideTileCard(
        onTap: onClick == null
            ? null
            : () {
                unawaited(AppHaptics.selectionClick());
                onClick!();
              },
        isActive: true,
        title: department.branch == Branch.main ? department.code : department.name,
        subtitle: department.branch == Branch.main ? department.name : null,
        activeShadows: null,
        activeGradient: department.gradient,
        trailing: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: SizedBox(
            width: WideTileCardConfig.imageSize,
            height: context.textScaler.scale(WideTileCardConfig.imageSize),
            child: Opacity(
              opacity: .5,
              child: Padding(
                padding: const EdgeInsets.all(DepartmentsConfig.logoMicroPadding),
                child: MyCachedImage(
                  department.logo?.effectiveUrl,
                  boxFit: BoxFit.scaleDown,
                  loadingType: LoadingType.noLoading,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
