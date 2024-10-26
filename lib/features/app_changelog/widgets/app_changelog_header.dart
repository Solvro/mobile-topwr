import "package:flutter/material.dart";

import "../../../theme/app_theme.dart";

class AppChangelogHeader extends StatelessWidget {
  const AppChangelogHeader({
    super.key, 
    this.version = "1.0.0",
  });

  final String version;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Wrap(
        children: [
          Text.rich(
            textAlign: TextAlign.start,
            TextSpan(
              children: [
                TextSpan(
                  text: "Zmiany",
                  style: context.textTheme.headlineOrange,
                ),
                const WidgetSpan(child: SizedBox(width: 5,)),
                TextSpan(
                  text: "wersja $version",
                  style: context.textTheme.bodyGrey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
