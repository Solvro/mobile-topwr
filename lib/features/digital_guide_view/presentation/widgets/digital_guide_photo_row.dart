import "dart:async";

import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";

import "../../../../config/ui_config.dart";
import "../../../../utils/context_extensions.dart";
import "digital_guide_carousel.dart";
import "digital_guide_image.dart";
import "digital_guide_nav_link.dart";

class DigitalGuidePhotoRow extends StatelessWidget {
  final IList<int> imagesIDs;

  const DigitalGuidePhotoRow({super.key, required this.imagesIDs});

  @override
  Widget build(BuildContext context) {
    if (imagesIDs.isEmpty) {
      return const SizedBox.shrink();
    }

    final displayImages = imagesIDs.take(3).toIList();

    return Column(
      children: [
        SizedBox(
          height: DigitalGuideConfig.photoRowHeight,
          child: Row(
            children: displayImages
                .map(
                  (id) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: DigitalGuideConfig.paddingSmall,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          DigitalGuideConfig.borderRadiusMedium,
                        ),
                        child: DigitalGuideImage(id: id),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        if (imagesIDs.length > 3)
          Padding(
            padding: const EdgeInsets.only(
              top: DigitalGuideConfig.heightSmall,
            ),
            child: DigitalGuideNavLink(
              onTap: () async => showGallery(context),
              text: context.localize.see_all_photos(imagesIDs.length),
            ),
          ),
      ],
    );
  }

  Future<void> showGallery(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => DigitalGuideCarouselWithIndicator(
        imgListId: imagesIDs,
      ),
    );
  }
}
