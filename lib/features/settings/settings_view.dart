import "dart:async";
import "dart:math";

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_svg/svg.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

import "../../../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../gen/assets.gen.dart";
import "../../services/translations_service/data/preferred_lang_repository.dart";
import "../../widgets/horizontal_symmetric_safe_area.dart";
import "../branches/data/model/branch.dart";
import "../branches/data/repository/branch_repository.dart";
import "../branches/presentation/branch_dialog.dart";
import "../digital_guide/tabs/accessibility_dialog/presentation/accessibility_dialog.dart";
import "../navigation_tab_view/widgets/navigation_tile.dart";
import "../navigator/utils/navigation_commands.dart";
import "widgets/language_settings_dialog.dart";

@RoutePage()
class SettingsView extends ConsumerWidget {
  const SettingsView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgets = [
      NavigationTile(
        onTap: () async {
          final selectedLang = await LanguageDialog.show(context);
          if (selectedLang != null) {
            final supportedLocale = SolvroLocale.values.byName(selectedLang);
            await ref.read(preferredLanguageRepositoryProvider.notifier).setPreferredLanguage(supportedLocale);
          }
        },
        title: context.localize.language,
        icon: Icons.speaker_notes_rounded,
      ),
      NavigationTile(
        onTap: () async {
          final selectedBranch = await BranchDialog.show(context);
          if (selectedBranch != null) {
            final branch = Branch.fromName(selectedBranch);
            await ref.read(branchRepositoryProvider.notifier).setBranch(branch);
          }
        },
        title: context.localize.branch,
        icon: Icons.house,
      ),
      NavigationTile(
        onTap: () => unawaited(AccessibilityDialog.show(context, ref)),
        title: context.localize.digital_guide_accessibility,
        icon: Icons.accessibility_new,
      ),
      NavigationTile(
        onTap: ref.navigateToSksFavouriteDishes,
        title: context.localize.sks_favourite_dishes_see_dishes,
        icon: Icons.food_bank,
      ),
      Padding(
        padding: const EdgeInsets.all(AboutUsConfig.spacerHeight),
        child: SizedBox.square(
          dimension: min(MediaQuery.sizeOf(context).width, MediaQuery.sizeOf(context).height) * 0.5,
          child: SvgPicture.asset(Assets.svg.settings),
        ),
      ),
    ];

    return HorizontalSymmetricSafeAreaScaffold(
      backgroundColor: context.colorTheme.whiteSoap,
      appBar: DetailViewAppBar(title: (text: context.localize.settings, context: context)),
      body: Padding(
        padding: const EdgeInsets.all(AboutUsConfig.spacerHeight),
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widgets.length,
          itemBuilder: (context, index) => widgets[index],
          separatorBuilder: (context, index) => const SizedBox(height: AboutUsConfig.spacerHeight),
          shrinkWrap: true,
        ),
      ),
    );
  }
}
