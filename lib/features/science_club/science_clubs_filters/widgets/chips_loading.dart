import "package:flutter/material.dart";

import "../../../../config/ui_config.dart";
import "../../../../widgets/loading_widgets/specific_imitations/button_loading.dart";

class FilterChipsLoading extends StatelessWidget {
  const FilterChipsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(FilterConfig.paddingMedium),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * FilterConfig.bottomSheetHeightFactor / 2,
        child: GridView.builder(
          gridDelegate: ScienceClubsViewConfig.tagsGridDelegate,
          itemBuilder: (context, index) => const ButtonLoading(),
          physics: const NeverScrollableScrollPhysics(),
        ),
      ),
    );
  }
}
