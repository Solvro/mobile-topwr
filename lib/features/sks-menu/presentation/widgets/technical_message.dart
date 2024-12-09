import "package:flutter/material.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../data/models/dish_category_enum.dart";

class TechnicalMessage extends StatelessWidget {
  const TechnicalMessage({
    super.key,
    required this.message,
    this.title,
    this.color,
  });
  final String message;
  final String? title;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        HomeViewConfig.paddingMedium,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: ColoredBox(
          color: color ?? context.colorTheme.orangePomegranade,
          child: ListTile(
            title: Text(
              title ?? DishCategory.technicalInfo.getLocalizedName(context),
              style: context.textTheme.titleWhite,
            ),
            subtitle: Text(
              message,
              style: context.textTheme.bodyWhite,
            ),
          ),
        ),
      ),
    );
  }
}
