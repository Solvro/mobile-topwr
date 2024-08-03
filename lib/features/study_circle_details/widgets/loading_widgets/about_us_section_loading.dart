import "package:flutter/material.dart";
import "../../../../config/ui_config.dart";
import "../../../../widgets/loading_widgets/scrolable_loader_builder.dart";
import "../../../../widgets/loading_widgets/shimmer_loading.dart";

class AboutUsSectionLoading extends StatelessWidget {
  const AboutUsSectionLoading({super.key});

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
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const SizedBox(height: DetailsScreenConfig.spacerHeight),
          SizedBox(
            height: MediaQuery.of(context).size.height / 10,
            child: ShimmerLoadingItem(
              child: ScrollableLoaderBuilder(
                mainAxisItemSize: 16,
                itemsSpacing: 4,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 16,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
