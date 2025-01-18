import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../../utils/launch_url_util.dart";
import "../../../../../widgets/my_error_widget.dart";
import "../../../data/models/digital_guide_response.dart";
import "../../../data/repository/image_repository.dart";

class LocalizationExpansionTileContent extends ConsumerWidget {
  const LocalizationExpansionTileContent({
    super.key,
    required this.digitalGuideData,
  });

  final DigitalGuideResponse digitalGuideData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncImageUrl =
        ref.watch(imageRepositoryProvider(digitalGuideData.locationMapId));

    return asyncImageUrl.when(
      data: (imageUrl) => _LocalizationExpansionTileContent(
        imageUrl: imageUrl,
        buildingName: digitalGuideData.translations.plTranslation.name,
        buildingAddress: digitalGuideData.translations.plTranslation.address,
      ),
      error: (error, stackTrace) => MyErrorWidget(error),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _LocalizationExpansionTileContent extends ConsumerWidget {
  const _LocalizationExpansionTileContent({
    required this.imageUrl,
    required this.buildingName,
    required this.buildingAddress,
  });

  final String? imageUrl;
  final String buildingName;
  final String buildingAddress;

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
              ),
            ),
          ),
        TextButton.icon(
          icon: Icon(
            Icons.navigation,
            color: context.colorTheme.orangePomegranade,
            size: 16,
          ),
          onPressed: () async =>
              _navigateToBuilding(context, ref, buildingName, buildingAddress),
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

  Future<void> _navigateToBuilding(
    BuildContext context,
    WidgetRef ref,
    String buildingName,
    String buildingAddress,
  ) async {
    final query = "$buildingName, $buildingAddress";
    final googleMapsUrl =
        "https://www.google.com/maps/dir/?api=1&destination=${Uri.encodeComponent(query)}&travelmode=driving&origin=current+location";
    await ref.launch(googleMapsUrl);
  }
}
