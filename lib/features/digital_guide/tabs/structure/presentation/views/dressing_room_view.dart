import "package:auto_route/auto_route.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../../config/ui_config.dart";
import "../../../../../../theme/app_theme.dart";
import "../../../../../../utils/context_extensions.dart";
import "../../../../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../../../../widgets/horizontal_symmetric_safe_area.dart";
import "../../../../presentation/widgets/accessibility_button.dart";
import "../../../../presentation/widgets/accessibility_profile_card.dart";
import "../../../../presentation/widgets/digital_guide_photo_row.dart";
import "../../../dressing_room/data/models/digital_guide_dressing_room.dart";
import "../../../dressing_room/domain/dressing_room_accessibility_comments_manager.dart";

@RoutePage()
class DressingRoomView extends ConsumerWidget {
  const DressingRoomView({required this.dressingRoom, super.key});

  final DigitalGuideDressingRoom dressingRoom;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dressingRoomInformation = dressingRoom.translations.pl;

    return HorizontalSymmetricSafeAreaScaffold(
      appBar: DetailViewAppBar(actions: [AccessibilityButton()]),
      body: Padding(
        padding: const EdgeInsets.all(DigitalGuideConfig.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.localize.dressing_room,
              style: context.textTheme.headlineMedium?.copyWith(fontSize: DigitalGuideConfig.headlineFont),
            ),
            const SizedBox(height: DigitalGuideConfig.heightSmall),
            Text(context.localize.localization, style: context.textTheme.titleLarge),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: DigitalGuideConfig.heightSmall),
              child: Text(dressingRoomInformation.location),
            ),
            if (dressingRoomInformation.workingDaysAndHours.isNotEmpty)
              Text(context.localize.working_hours, style: context.textTheme.titleLarge),
            if (dressingRoomInformation.workingDaysAndHours.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: DigitalGuideConfig.heightSmall),
                child: Text(dressingRoomInformation.workingDaysAndHours),
              ),
            if (dressingRoomInformation.comment.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: DigitalGuideConfig.paddingSmall),
                child: Text(context.localize.additional_information, style: context.textTheme.titleLarge),
              ),
            Text(dressingRoomInformation.comment),
            if (dressingRoomInformation.comment.isNotEmpty) const SizedBox(height: DigitalGuideConfig.heightMedium),
            DigitalGuidePhotoRow(imagesIDs: dressingRoom.imagesIds?.toIList() ?? const IList.empty()),
            const SizedBox(height: DigitalGuideConfig.heightSmall),
            AccessibilityProfileCard(
              accessibilityCommentsManager: DressingRoomAccessibilityCommentsManager(
                l10n: context.localize,
                dressingRoomResponse: dressingRoom,
              ),
              backgroundColor: context.colorScheme.surface,
            ),
          ],
        ),
      ),
    );
  }
}
