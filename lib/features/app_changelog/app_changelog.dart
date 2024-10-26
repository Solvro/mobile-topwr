import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "../../theme/app_theme.dart";
import "repository/changelog_repository.dart";
import "widgets/app_changelog_header.dart";
import "widgets/app_changelog_list.dart";


class AppChangelog extends StatelessWidget {
  const AppChangelog({
    super.key, 
    required this.changelog,
  });

  final Changelog changelog;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(25),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.6,
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        decoration: BoxDecoration(
          color: context.colorTheme.whiteSoap,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppChangelogHeader(version: changelog.versionString!,),
                const SizedBox(height: 15,),
                AppChangelogList(changelog: changelog),
              ],
            ),
            Positioned(
              right: 0,
              top: 0,
              child: GestureDetector(
                onTap: context.maybePop, 
                child: Icon(
                  Icons.close,
                  color: context.colorTheme.greyPigeon,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
