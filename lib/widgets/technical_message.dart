import "package:flutter/material.dart";

import "../config/ui_config.dart";
import "../features/sks/sks_menu/data/models/dish_category_enum.dart";
import "../services/translations_service/widgets/text_with_translation.dart";
import "../theme/app_theme.dart";

enum AlertType { info, error }

class TechnicalMessage extends StatelessWidget {
  const TechnicalMessage({
    super.key,
    required this.message,
    this.title,
    this.alertType = AlertType.error,
    this.icon,
    this.onTap,
    this.backgoundColor,
    this.textColor,
    this.translate = false,
  });
  final String message;
  final String? title;
  final AlertType alertType;
  final Icon? icon;
  final VoidCallback? onTap;
  final Color? backgoundColor;
  final Color? textColor;
  final bool translate;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(HomeViewConfig.paddingMedium),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppWidgetsConfig.borderRadiusMedium),
        child: ColoredBox(
          color:
              backgoundColor ??
              (alertType == AlertType.error ? context.colorTheme.orangePomegranade : context.colorTheme.blueAzure),
          child: ListTile(
            onTap: onTap,
            trailing: icon,
            title: TextWithTranslation(
              title ?? DishCategory.technicalInfo.getLocalizedName(context),
              style: context.textTheme.titleWhite,
              translate: translate,
            ),
            subtitle: TextWithTranslation(
              message,
              style: context.textTheme.bodyWhite.copyWith(color: textColor),
              translate: translate,
            ),
          ),
        ),
      ),
    );
  }
}
