import "package:flutter/material.dart";

import "../../config/ui_config.dart";
import "shimmer_loading.dart";

class HeaderSectionLoading extends StatelessWidget {
  const HeaderSectionLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoadingItem(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Container(height: 250, width: double.maxFinite, color: ShimmerLoadingConfig.placeholderColor),
              Positioned(
                top: 185,
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: ShimmerLoadingConfig.placeholderColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 84),
          Container(
            height: 24,
            width: 350,
            decoration: BoxDecoration(
              color: ShimmerLoadingConfig.placeholderColor,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 24,
            width: 200,
            decoration: BoxDecoration(
              color: ShimmerLoadingConfig.placeholderColor,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ],
      ),
    );
  }
}
