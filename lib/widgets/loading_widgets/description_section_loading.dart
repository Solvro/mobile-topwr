import "package:flutter/material.dart";

import "../../config/ui_config.dart";
import "scrolable_loader_builder.dart";
import "shimmer_loading.dart";

class DescriptionSectionLoading extends StatelessWidget {
  const DescriptionSectionLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerLoadingItem(
            child: Container(
              height: 24,
              width: 100,
              decoration: BoxDecoration(
                color: ShimmerLoadingConfig.placeholderColor,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const SizedBox(height: DetailViewsConfig.spacerHeight),
          SizedBox(
            height: MediaQuery.sizeOf(context).height / 10,
            child: ShimmerLoadingItem(
              child: ScrollableLoaderBuilder(
                mainAxisItemSize: 16,
                itemsSpacing: 4,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => Container(
                  height: 16,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                    color: ShimmerLoadingConfig.placeholderColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
