import "package:flutter/material.dart";

import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";

class AppChangelogHeader extends StatelessWidget {
  const AppChangelogHeader({
    super.key, 
    required this.version,
  });

  final String version;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: context.localize.changes,
                style: context.textTheme.headlineOrange,
              ),
              const WidgetSpan(child: SizedBox(width: 5,)),
              TextSpan(
                text: "${context.localize.version} ${version.toUpperCase()}",
                style: context.textTheme.bodyGrey,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8,),
        Text(
          context.localize.hey_check_out_the_new_features,
          style: context.textTheme.headline,
        ),
        const SizedBox(height: 5,),
        Text(
          context.localize.here_you_will_see_what_we_changed_in_the_latest_version,
          style: context.textTheme.bodyGrey,
          overflow: TextOverflow.clip,
        ),
      ],
    );
  }
}
