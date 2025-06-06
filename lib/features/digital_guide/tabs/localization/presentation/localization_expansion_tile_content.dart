import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:latlong2/latlong.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../buildings_view/model/building_model.dart";
import "../../../../map_view/utils/google_maps_link_utils.dart";
import "../../../data/models/digital_guide_response.dart";
import "../../../presentation/widgets/digital_guide_image.dart";

class LocalizationExpansionTileContent extends ConsumerWidget {
  const LocalizationExpansionTileContent({super.key, required this.digitalGuideData, required this.building});

  final DigitalGuideResponse digitalGuideData;
  final BuildingModel building;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(DigitalGuideConfig.paddingMedium),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(DigitalGuideConfig.borderRadiusMedium),
            child: DigitalGuideImage(
              id: digitalGuideData.locationMapId,
              semanticsLabel: context.localize.localization_digital_guide_image_screen_reader_label,
            ),
          ),
        ),
        TextButton.icon(
          icon: Icon(Icons.navigation, color: context.colorTheme.orangePomegranade, size: 16),
          onPressed: () async => _navigateToBuilding(ref, building),
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

  Future<void> _navigateToBuilding(WidgetRef ref, BuildingModel building) async {
    final LatLng buildingCoordinates = LatLng(building.latitude, building.longitude);
    await GoogleMapsLinkUtils.navigateTo(buildingCoordinates, ref);
  }
}
