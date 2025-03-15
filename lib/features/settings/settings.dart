import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";

import "../navigation_tab_view/widgets/navigation_tile.dart";

@RoutePage()
class SettingsView extends ConsumerWidget {
  const SettingsView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgets = [
      Text(context.localize.settings, style: context.textTheme.headline),
      NavigationTile(onTap: () {}, title: context.localize.lenguage, icon: Icons.speaker_notes_rounded),
    ];

    return Scaffold(
      appBar: DetailViewAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(DigitalGuideConfig.paddingMedium),
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widgets.length,
          itemBuilder: (context, index) => widgets[index],
          separatorBuilder: (context, index) => const SizedBox(height: DigitalGuideConfig.heightSmall),
          shrinkWrap: true,
        ),
      ),
    );
  }
}
