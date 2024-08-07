import "package:flutter/material.dart";

import "../../../config/ui_config.dart";
import "../../../widgets/loading_widgets/specific_imitations/button_loading.dart";

class TagsLoading extends StatelessWidget {
  const TagsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: ScienceClubsViewConfig.smallPadding,
      ),
      child: GridView.builder(
        gridDelegate: ScienceClubsViewConfig.tagsGridDelegate,
        itemBuilder: (context, index) => const ButtonLoading(),
        physics: const NeverScrollableScrollPhysics(),
      ),
    );
  }
}
