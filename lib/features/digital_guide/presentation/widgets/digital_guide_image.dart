import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../widgets/loading_widgets/shimmer_loading.dart";
import "../../../../widgets/my_cached_image.dart";
import "../../../../widgets/my_error_widget.dart";
import "../../../../widgets/zoomable_images.dart";
import "../../data/repository/image_repository.dart";

class DigitalGuideImage extends ConsumerWidget {
  const DigitalGuideImage({required this.id, this.zoomable = true, this.semanticsLabel});

  final int id;
  final bool zoomable;
  final String? semanticsLabel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncImageUrl = ref.watch(imageRepositoryProvider(id));
    return asyncImageUrl.when(
      data:
          (url) =>
              zoomable
                  ? ZoomableCachedImage(url, semanticsLabel: semanticsLabel)
                  : MyCachedImage(url, semanticsLabel: semanticsLabel),
      error: (error, stackTrace) => MyErrorWidget(error),
      loading: () => Center(child: ShimmeringEffect(child: Container(color: Colors.white))),
    );
  }
}
