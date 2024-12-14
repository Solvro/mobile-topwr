import "package:flutter/material.dart";
import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../widgets/my_cached_image.dart";
import "../../../../widgets/my_html_widget.dart";
import "../../data/models/digital_guide_response_extended.dart";
import "../../presentation/widgets/digital_guide_go_to_button.dart";

class EvacuationWidget extends StatelessWidget {
  const EvacuationWidget({
    super.key,
    required this.digitalGuideResponseExtended,
  });

  final DigitalGuideResponseExtended digitalGuideResponseExtended;

  @override
  Widget build(BuildContext context) {
    final widgets = [
      const SizedBox(
        height: DigitalGuideConfig.heightSmall,
      ),
      MyHtmlWidget(
          digitalGuideResponseExtended
              .translations.plTranslation.evacuationDescription,
          textStyle: context.textTheme.boldBody),
      const SizedBox(
        height: DigitalGuideConfig.heightMedium,
      ),
      Text(
        context.localize.evacuation_text,
        style: context.textTheme.boldBody,
      ),
      const SizedBox(
        height: DigitalGuideConfig.heightMedium,
      ),
      MyCachedImage(digitalGuideResponseExtended.evacuationMapUrl),
      const SizedBox(
        height: DigitalGuideConfig.heightMedium,
      ),
      ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => DigitalGuideGoToButton(
          onTap: () {},
          entrace: digitalGuideResponseExtended.entraces[index],
        ),
        separatorBuilder: (context, index) => const SizedBox(
          height: DigitalGuideConfig.heightMedium,
        ),
        itemCount: digitalGuideResponseExtended.entraces.length,
        shrinkWrap: true,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: DigitalGuideConfig.heightMedium,
      ),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => widgets[index],
        itemCount: widgets.length,
        shrinkWrap: true,
      ),
    );
  }
}
