import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:url_launcher/url_launcher.dart";

import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../widgets/my_error_widget.dart";
import "../../../parkings_view/widgets/parkings_icons.icons.dart";
import "../data/repository/localization_repository.dart";

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
    final asyncBuildingDetails =
    ref.watch(getBuildingDetailsProvider(buildingId));

    return asyncBuildingDetails.when(
      data: (buildingDetails) => asyncImageUrl.when(
        data: (imageUrl) => _LocalizationExpansionTileContent(
          imageUrl: imageUrl,
          buildingName: buildingDetails?["name"] ?? "Unknown Building",
          buildingAddress: buildingDetails?["address"] ?? "Unknown Address",
          buildingId: buildingId,
        ),
        error: (error, stackTrace) => MyErrorWidget(error),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
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
    required this.buildingId,
    required this.buildingName,
    required this.buildingAddress,
  });

  final String? imageUrl;
  final int buildingId;
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
                errorBuilder: (context, error, stackTrace) =>
                const Center(child: Text("Cannot load photo")),
              ),
            ),
          )
        else
          const Center(child: Text("Photo not available")),
        TextButton.icon(
          icon: Icon(
            ParkingsIcons.map_nav,
            color: context.colorTheme.orangePomegranade,
            size: 16,
          ),
          onPressed: () async => _navigateToBuilding(context, buildingName, buildingAddress),
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
      BuildContext context, String buildingName, String buildingAddress,) async {
    final query = "$buildingName, $buildingAddress";
    final googleMapsUrl = Uri.parse(
      "https://www.google.com/maps/dir/?api=1&destination=${Uri.encodeComponent(query)}&travelmode=driving&origin=current+location",
    );
    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl);
    } else {
      const Text("Could not open Google Maps");
    }
  }
}
