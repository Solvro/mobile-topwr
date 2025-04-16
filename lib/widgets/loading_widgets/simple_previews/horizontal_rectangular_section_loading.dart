import "package:flutter/material.dart";

import "../../../config/ui_config.dart";
import "../shimmer_loading.dart";

class HorizontalRectangularSectionLoading extends StatelessWidget {
  const HorizontalRectangularSectionLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: HomeViewConfig.paddingMedium),
      child: ShimmeringEffect(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: HomeViewConfig.paddingMedium),
          child: Container(
            width: double.maxFinite,
            height: 69,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppWidgetsConfig.borderRadiusMedium),
            ),
          ),
        ),
      ),
    );
  }
}
