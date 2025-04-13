import "package:flutter/material.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../widgets/my_html_widget.dart";
import "../../data/models/digital_guide_response.dart";
import "../../presentation/widgets/digital_guide_image.dart";
import "entrances_list.dart";

class EvacuationWidget extends StatelessWidget {
  const EvacuationWidget({super.key, required this.digitalGuideData});

  final DigitalGuideResponse digitalGuideData;

  @override
  Widget build(BuildContext context) {
    final widgets = [
      const SizedBox(height: DigitalGuideConfig.heightSmall),
      MyHtmlWidget(
        digitalGuideData.translations.plTranslation.evacuationDescription,
        textStyle: context.textTheme.boldBody,
      ),
      const SizedBox(height: DigitalGuideConfig.heightMedium),
      Text(context.localize.evacuation_text, style: context.textTheme.boldBody),
      const SizedBox(height: DigitalGuideConfig.heightMedium),
      DigitalGuideImage(id: digitalGuideData.evacuationMapId),
      const SizedBox(height: DigitalGuideConfig.heightMedium),
      EntrancesList(digitalGuideData),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DigitalGuideConfig.heightMedium),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => widgets[index],
        itemCount: widgets.length,
        shrinkWrap: true,
      ),
    );
  }
}
