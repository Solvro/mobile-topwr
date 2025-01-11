import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";

import "../../../../config/ui_config.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../widgets/zoomable_images.dart";
import "digital_guide_nav_link.dart";

class DigitalGuidePhotoRow extends StatelessWidget {
  final IList<String?> imageUrls;

  const DigitalGuidePhotoRow({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    if (imageUrls.isEmpty) {
      return const SizedBox.shrink();
    }

    final displayImages = imageUrls.take(3).toIList();

    return Column(
      children: [
        SizedBox(
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
                        child: ZoomableCachedImage(url),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        if (imageUrls.length > 3)
          Padding(
            padding: const EdgeInsets.only(
              top: DigitalGuideConfig.heightSmall,
            ),
            child: DigitalGuideNavLink(
              onTap: () => {},
              text: context.localize.see_all_photos(imageUrls.length),
            ),
          ),
      ],
    );
  }
}
