import "package:flutter/material.dart";

import "../../../config/ui_config.dart";
import "../../../services/translations_service/widgets/my_html_widget_with_translation.dart";
import "../../../theme/app_theme.dart";
import "../../../widgets/my_expansion_tile.dart";

class FaqExpansionTile extends StatelessWidget {
  const FaqExpansionTile({super.key, required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: GuideDetailViewConfig.paddingMedium),
      child: MyExpansionTile(
        title: title,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: GuideDetailViewConfig.paddingSmall),
            child: ListTile(
              title: MyHtmlWidgetWithTranslation(description, textStyle: context.textTheme.body.copyWith(fontSize: 14)),
            ),
          ),
        ],
      ),
    );
  }
}
