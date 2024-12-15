import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../widgets/my_error_widget.dart";
import "../../../map_view/controllers/controllers_set.dart";
import "../../../parkings_view/widgets/parkings_icons.icons.dart";
import "../data/repository/localization_repository.dart";
import "../../../bottom_scroll_sheet/navigate_button.dart";

class LocalizationExpansionTileContent extends ConsumerWidget {
  const LocalizationExpansionTileContent({
    super.key,
    required this.buildingId,
  });

  final int buildingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncImageUrl =
        ref.watch(getImageUrlFromBuildingProvider(buildingId));

    return asyncImageUrl.when(
      data: (imageUrl) => _LocalizationExpansionTileContent(imageUrl: imageUrl),
      error: (error, stackTrace) => MyErrorWidget(error),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _LocalizationExpansionTileContent <T extends GoogleNavigable> extends ConsumerWidget {
  const _LocalizationExpansionTileContent({
    required this.imageUrl,
  });

  final String? imageUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        if (imageUrl != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Center(child: Text("Cannot load photo")),
              ),
            ),
          )
        else
          const Center(child: Text("Photo not available")),
         /*

         * i will probably change TextButton.icon to NavigateButton<T> like here:
         if (ref.watch(context.activeMarkerController<T>()) != null) NavigateButton<T>(),
         *
         * but it doesnt work
         * */
        TextButton.icon(
          icon: Icon(
            ParkingsIcons.map_nav,
            color: context.colorTheme.orangePomegranade,
            size: 16,
          ),
          onPressed: () {

          },
          label: Text.rich(
            TextSpan(
              text: context.localize.navigate_to_building,
              style: context.textTheme.bodyOrange.copyWith(
                decoration: TextDecoration.underline,
                decorationColor: context.colorTheme.orangePomegranade,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
