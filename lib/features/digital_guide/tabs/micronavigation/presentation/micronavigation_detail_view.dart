import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

import "../../../../../config/ui_config.dart";

import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../../../widgets/horizontal_symmetric_safe_area.dart";
import "../../../../../widgets/my_html_widget.dart";
import "../../../presentation/widgets/accessibility_button.dart";
import "../data/models/micronavigation_response.dart";
import "widgets/my_audio_player.dart";

@RoutePage()
class MicronavigationDetailView extends StatelessWidget {
  const MicronavigationDetailView({super.key, required this.micronavigationResponse});

  final MicronavigationResponse micronavigationResponse;

  @override
  Widget build(BuildContext context) {
    final widgets = [
      const SizedBox(height: DigitalGuideConfig.heightMedium),
      Focus(
        autofocus: true,
        child: Text(
          context.solvroLocale == SolvroLocale.pl
              ? micronavigationResponse.nameOverride.pl ?? micronavigationResponse.nameOverride.en ?? ""
              : micronavigationResponse.nameOverride.en ?? micronavigationResponse.nameOverride.pl ?? "",
          style: context.textTheme.titleLarge?.copyWith(fontSize: 24),
        ),
      ),
      const SizedBox(height: DigitalGuideConfig.heightBig),
      Text(context.localize.communique, style: context.textTheme.titleLarge),
      const SizedBox(height: DigitalGuideConfig.heightMedium),
      MyHtmlWidget(micronavigationResponse.webContent.pl ?? micronavigationResponse.webContent.en ?? ""),
      const SizedBox(height: DigitalGuideConfig.heightMedium),
      Text(context.localize.audio_message, style: context.textTheme.titleLarge),
      const SizedBox(height: DigitalGuideConfig.heightMedium),
      Text(context.localize.audio_message_comment, style: context.textTheme.bodyLarge),
      Padding(
        padding: DigitalGuideConfig.symetricalPaddingBig,
        child: MyAudioPlayer(
          audioUrl: context.solvroLocale == SolvroLocale.pl
              ? micronavigationResponse.languages.where((a) => a.langCode == "pl").firstOrNull?.sound ?? ""
              : micronavigationResponse.languages.where((a) => a.langCode == "en").firstOrNull?.sound ?? "",
        ),
      ),
    ];

    return HorizontalSymmetricSafeAreaScaffold(
      backgroundColor: context.colorScheme.surfaceTint,
      appBar: DetailViewAppBar(actions: [AccessibilityButton()]),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DigitalGuideConfig.paddingBig),
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widgets.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => widgets[index],
        ),
      ),
    );
  }
}
