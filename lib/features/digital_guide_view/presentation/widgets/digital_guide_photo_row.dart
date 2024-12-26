import "package:flutter/material.dart";

import "../../../../config/ui_config.dart";

class DigitalGuidePhotoRow extends StatelessWidget {
  final List<String?>? imageUrls;

  const DigitalGuidePhotoRow({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    if (imageUrls == null || imageUrls!.isEmpty) {
      return const SizedBox.shrink();
    }

    final displayImages = imageUrls!.take(3).toList();

    return SizedBox(
      height: DigitalGuideConfig.photoRowHeight,
      child: Row(
        children: displayImages
            .map(
              (url) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: DigitalGuideConfig.paddingSmall,),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        DigitalGuideConfig.borderRadiusMedium,),
                    child: Image.network(
                      url!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
