import "package:flutter/material.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";

class EmptySubscribedDishesPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SksMenuConfig.paddingMedium),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SksMenuConfig.borderRadius),
        border: Border.all(color: context.colorTheme.orangePomegranade.withAlpha(50)),
      ),
      child: Column(
        spacing: SksMenuConfig.paddingMedium,
        children: [
          Icon(Icons.notifications_none, size: 48, color: context.colorTheme.greyPigeon),
          Text(
            context.localize.sks_favourite_dishes_no_dishes_yet,
            style: context.textTheme.title,
            textAlign: TextAlign.center,
          ),
          Text(
            context.localize.sks_favourite_dishes_how_it_works,
            style: context.textTheme.bodyGrey,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
