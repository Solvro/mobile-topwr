import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../widgets/loading_widgets/shimmer_loading.dart";
import "../../../../widgets/my_cached_image.dart";
import "../../../../widgets/my_error_widget.dart";
import "../../data/repository/image_repository.dart";

class DigitalGuideImage extends ConsumerWidget {
  const DigitalGuideImage({
    required this.id,
  });

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncImageUrl = ref.watch(getImageUrlProvider(id));
    return asyncImageUrl.when(
      data: MyCachedImage.new,
      error: (error, stackTrace) => MyErrorWidget(error),
      loading: () => Center(
        child: ShimmeringEffect(
          child: Container(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
