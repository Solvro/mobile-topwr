import "package:auto_route/auto_route.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../../config/ui_config.dart";
import "../../../../../../theme/app_theme.dart";
import "../../../../../../utils/context_extensions.dart";
import "../../../../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../../presentation/widgets/accessibility_button.dart";
import "../../../../presentation/widgets/accessibility_profile_card.dart";
import "../../../../presentation/widgets/bullet_list.dart";
import "../../business/parking_accessibility_comments_manager.dart";
import "../../data/models/parking.dart";

@RoutePage()
class ParkingView extends ConsumerWidget {
  const ParkingView({required this.parking});

  final DigitalGuideParking parking;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DigitalGuideParkingTranslation parkingsInformation = parking.translations.plTranslation;

    return Scaffold(
      appBar: DetailViewAppBar(actions: [AccessibilityButton()]),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DigitalGuideConfig.heightBig),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.localize.parking,
              style: context.textTheme.headline.copyWith(fontSize: DigitalGuideConfig.headlineFont),
            ),
            const SizedBox(height: DigitalGuideConfig.heightSmall),
            BulletList(
              items:
                  [
                    context.localize.parking_entry_location + parkingsInformation.entryLocation,
                    context.localize.is_parking_entry_from_ground_level(parking.isEntryFromGroundLevel.toLowerCase()) +
                        parkingsInformation.isEntryFromGroundLevelComment,
                    parkingsInformation.comment,
                    context.localize.is_parking_set_maximum_vehicle_height(
                          parking.isSetMaximumVehicleHeight.toLowerCase(),
                        ) +
                        parkingsInformation.isSetMaximumVehicleHeightComment,
                    context.localize.parking_permissions_types(parking.permissionsTypes),
                  ].toIList(),
            ),
            const SizedBox(height: DigitalGuideConfig.heightBig),
            AccessibilityProfileCard(
              accessibilityCommentsManager: ParkingsAccessibilityCommentsManager(
                l10n: context.localize,
                parking: parking,
              ),
              backgroundColor: context.colorTheme.whiteSoap,
            ),
          ],
        ),
      ),
    );
  }
}
