import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";

import "../../../../config/ui_config.dart";
import "../../../../widgets/my_cached_image.dart";

class DigitalGuidePhotoRow extends StatelessWidget {
  final List<String?>? imageUrls;

  const DigitalGuidePhotoRow({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    if (imageUrls == null || imageUrls!.isEmpty) {
      return const SizedBox.shrink();
    }

    final displayImages = imageUrls!.take(3).toIList();

    return SizedBox(
      height: DigitalGuideConfig.photoRowHeight,
      child: Row(
        children: displayImages
            .map(
              (url) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DigitalGuideConfig.paddingSmall,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      DigitalGuideConfig.borderRadiusMedium,
                    ),
                    child: MyCachedImage(
                      url,
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
