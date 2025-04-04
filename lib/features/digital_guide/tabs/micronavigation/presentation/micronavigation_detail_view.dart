import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../services/translations_service/widgets/my_html_widget_with_translation.dart";
import "../../../../../services/translations_service/widgets/text_with_translation.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../../../widgets/horizontal_symmetric_safe_area.dart";
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
      TextWithTranslation(
        micronavigationResponse.nameOverride.pl ?? "",
        style: context.textTheme.title.copyWith(fontSize: 24),
      ),
      const SizedBox(height: DigitalGuideConfig.heightBig),
      Text(context.localize.communique, style: context.textTheme.title),
      const SizedBox(height: DigitalGuideConfig.heightMedium),
      MyHtmlWidgetWithTranslation(micronavigationResponse.webContent.pl ?? ""),
      const SizedBox(height: DigitalGuideConfig.heightMedium),
      Text(context.localize.audio_message, style: context.textTheme.title),
      const SizedBox(height: DigitalGuideConfig.heightMedium),
      Text(context.localize.audio_message_comment, style: context.textTheme.body),
      Padding(
        padding: DigitalGuideConfig.symetricalPaddingBig,
        child: MyAudioPlayer(
          audioUrl: micronavigationResponse.languages.where((a) => a.langCode == "pl").firstOrNull?.sound ?? "",
        ),
      ),
    ];

    return HorizontalSymmetricSafeAreaScaffold(
      backgroundColor: context.colorTheme.greyLight,
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
