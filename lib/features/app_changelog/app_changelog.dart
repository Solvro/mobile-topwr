import "package:flutter/material.dart";
import "../../theme/app_theme.dart";
import "widgets/app_changelog_header.dart";


class AppChangelog extends StatelessWidget {
  const AppChangelog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(25),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        decoration: BoxDecoration(
          color: context.colorTheme.whiteSoap,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Column(
          children: [
            AppChangelogHeader(),
          ],
        )
      ),
    );
  }
}
