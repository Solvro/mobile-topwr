import "package:flutter/material.dart";
import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../theme/utils.dart";
import "../../../../widgets/my_cached_image.dart";
import "../../../../widgets/optimized_directus_image.dart";
import "../../../../widgets/wide_tile_card.dart";
import "../data/models/department.dart";
import "../data/utils/departments_extensions.dart";

class DepartmentCard extends StatelessWidget {
  final Department department;
  const DepartmentCard(this.department, {super.key, this.onClick});
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: context.defaultThemeWithOverrideTextStyles(
        titleWhite: context.textTheme.titleWhite.copyWith(
          shadows: HomeViewConfig.squareCardTextShadow,
          // Ensure minimum font size for accessibility
          fontSize: _getAccessibleFontSize(context.textTheme.titleWhite.fontSize ?? 16),
        ),
        bodyWhite: context.textTheme.bodyWhite.copyWith(
          shadows: HomeViewConfig.squareCardTextShadow,
          // Ensure minimum font size for accessibility
          fontSize: _getAccessibleFontSize(context.textTheme.bodyWhite.fontSize ?? 14),
        ),
      ),
      child: Semantics(
        // Provide comprehensive semantic information for screen readers
        button: onClick != null,
        enabled: onClick != null,
        onTap: onClick,
        label: "Department ${department.name}, code ${department.code}",
        hint: onClick != null ? "Tap to view department details" : null,
        // Group related content together
        container: true,
        child: WideTileCard(
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
                child: Padding(
                  padding: const EdgeInsets.all(DepartmentsConfig.logoMicroPadding),
                  child: Semantics(
                    // Provide alt text for the image
                    image: true,
                    label: "${department.name} department logo",
                    child: OptimizedDirectusImage(
                      department.imageUrl,
                      boxFit: BoxFit.scaleDown,
                      loadingType: LoadingType.noLoading,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Ensures font size meets accessibility guidelines
  /// Minimum font size should be at least 12sp, preferably 14sp+
  double _getAccessibleFontSize(double originalSize) {
    const double minFontSize = 14;
    return originalSize < minFontSize ? minFontSize : originalSize;
  }
}
