import 'package:flutter/material.dart';

import '../../../config.dart';
import '../../../repositories/scientific_circles/scientific_circles_repository.dart';
import '../../../widgets/my_cached_image.dart';
import '../../../widgets/wide_tile_card.dart';

class ResearchGroupCard extends StatelessWidget {
  final ScientificCircle sciCircle;
  const ResearchGroupCard(this.sciCircle, {super.key});

  @override
  Widget build(BuildContext context) {
    return WideTileCard(
      isActive: false,
      title: sciCircle.name,
      subtitle: sciCircle.department?.name ?? "",
      secondSubtitle:
          sciCircle.tags?.map((tag) => '#${tag!.name}').toList().join(', '),
      activeShadows: null,
      trailing: Padding(
        padding: const EdgeInsets.only(right: 2, top: 2, bottom: 2),
        child: SizedBox.square(
          dimension: WideTileCardConfig.imageSize,
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: WideTileCardConfig.radius,
                  bottomRight: WideTileCardConfig.radius),
            ),
            child: MyCachedImage(
              sciCircle.photo?.url,
              boxFit: BoxFit.contain,
              noShimmeringLoading: true,
            ),
          ),
        ),
      ),
    );
  }
}
