import 'package:flutter/material.dart';
import '../../../../config.dart';
import '../../../../widgets/loading_widgets/shimmer_loading.dart';

class AboutUsSectionLoading extends StatelessWidget {
  const AboutUsSectionLoading({super.key});

  @override
  Widget build(BuildContext context) {

    final numberOfVisibleItems = ((MediaQuery.of(context).size.height/10) ~/ 20);

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
            height: MediaQuery.of(context).size.height/10,
            width: double.maxFinite,
            child: ShimmerLoadingItem(
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return  Container(
                    height: 16,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 4);
                },
                itemCount: numberOfVisibleItems,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
