import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/app_theme.dart';
import '../../utils/context_extensions.dart';
import '../navigator/navigator/detail_view_navigator.dart';
import '../navigator/navigator/nested_navigator.dart';

class GuideViewTemplate extends ConsumerWidget {
  const GuideViewTemplate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localize.about_us),
        backgroundColor: context.colorTheme.greyLight,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: ref.watch(navigatorProvider).navigateToAboutUs,
              child: Container(
                padding: const EdgeInsets.all(10.0),
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
                      color: context.colorTheme.orangePomegranade),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
