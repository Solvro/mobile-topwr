import "package:flutter/material.dart";

import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";

class RadioPlayerInfo extends StatelessWidget {
  const RadioPlayerInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.localize.radio_luz_title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.titleWhite.copyWith(fontSize: 14),
          ),
          Text(
            context.localize.radio_luz_subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.bodyWhite.copyWith(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
