import "package:flutter/material.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../data/models/dish_category_enum.dart";

enum AlertType { info, error }

class TechnicalMessage extends StatelessWidget {
  const TechnicalMessage({
    super.key,
    required this.message,
    this.title,
    this.alertType = AlertType.error,
  });
  final String message;
  final String? title;
  final AlertType alertType;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        HomeViewConfig.paddingMedium,
      ),
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(AppWidgetsConfig.borderRadiusMedium),
        child: ColoredBox(
          color: alertType == AlertType.error
              ? context.colorTheme.orangePomegranade
              : context.colorTheme.blueAzure,
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
