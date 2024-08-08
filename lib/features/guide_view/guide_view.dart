import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../theme/app_theme.dart";
import "../../utils/context_extensions.dart";
import "../navigator/utils/navigation_commands.dart";

@RoutePage()
class GuideView extends ConsumerWidget {
  const GuideView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localize.about_us),
        backgroundColor: context.colorTheme.greyLight,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            GestureDetector(
              onTap: ref.navigateAboutUs,
              child: Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: context.colorTheme.greyLight,
                ),
                child: Text(
                  context.localize.about_us,
                  style: TextStyle(
                    fontSize: 24,
                    color: context.colorTheme.orangePomegranade,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: ref.navigateGuideDetail,
              child: Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: context.colorTheme.greyLight,
                ),
                child: Text(
                  "Przykładowy wpis",
                  style: TextStyle(
                    fontSize: 24,
                    color: context.colorTheme.orangePomegranade,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
