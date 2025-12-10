import "package:flutter/material.dart";

import "../../../../config/ui_config.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../widgets/my_cached_image.dart";
import "../../../../widgets/wide_tile_card.dart";
import "../data/models/department.dart";
import "../data/utils/departments_extensions.dart";

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
        child: SizedBox(
          width: WideTileCardConfig.imageSize,
          height: context.textScaler.scale(WideTileCardConfig.imageSize),
          child: Opacity(
            opacity: .5,
            child: Padding(
              padding: const EdgeInsets.all(DepartmentsConfig.logoMicroPadding),
              child: MyCachedImage(department.imageUrl, boxFit: BoxFit.scaleDown, loadingType: LoadingType.noLoading),
            ),
          ),
        ),
      ),
    );
  }
}
