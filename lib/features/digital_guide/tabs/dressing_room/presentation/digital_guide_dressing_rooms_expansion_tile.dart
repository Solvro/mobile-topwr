import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../../widgets/my_error_widget.dart";
import "../../../data/models/digital_guide_response.dart";
import "../../../presentation/widgets/digital_guide_photo_row.dart";
import "../data/models/digital_guide_dressing_room.dart";
import "../data/repository/dressing_rooms_repository.dart";

class DigitalGuideDressingRoomsExpansionTileContent extends ConsumerWidget {
  const DigitalGuideDressingRoomsExpansionTileContent(
    this.digitalGuideResponse,
  );

  final DigitalGuideResponse digitalGuideResponse;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dressingRoomsResponse =
        ref.watch(dressingRoomsRepositoryProvider(digitalGuideResponse));
    return dressingRoomsResponse.when(
      data: (data) => _DigitalGuideDressingRoomsExpansionTileContent(
        dressingRoom: data.firstOrNull,
      ),
      error: (error, _) => MyErrorWidget(error),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _DigitalGuideDressingRoomsExpansionTileContent extends StatelessWidget {
  final DigitalGuideDressingRoom? dressingRoom;

  const _DigitalGuideDressingRoomsExpansionTileContent({
    required this.dressingRoom,
  });

  @override
  Widget build(BuildContext context) {
    if (dressingRoom == null) {
      return Center(
        child: Text(context.localize.no_dressing_room_in_the_building),
      );
    }
    final dressingRoomInformation = dressingRoom!.translations.pl;
    return Padding(
      padding: const EdgeInsets.all(DigitalGuideConfig.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.localize.localization, style: context.textTheme.title),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: DigitalGuideConfig.heightSmall,
            ),
            child: Text(dressingRoomInformation.location),
          ),
          if (dressingRoomInformation.workingDaysAndHours.isNotEmpty)
            Text(
              context.localize.working_hours,
              style: context.textTheme.title,
            ),
          if (dressingRoomInformation.workingDaysAndHours.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: DigitalGuideConfig.heightSmall,
              ),
              child: Text(dressingRoomInformation.workingDaysAndHours),
            ),
          if (dressingRoomInformation.comment.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(
                bottom: DigitalGuideConfig.paddingSmall,
              ),
              child: Text(
                context.localize.additional_information,
                style: context.textTheme.title,
              ),
            ),
          Text(dressingRoomInformation.comment),
          if (dressingRoomInformation.comment.isNotEmpty)
            const SizedBox(
              height: DigitalGuideConfig.heightMedium,
            ),
          DigitalGuidePhotoRow(
            imagesIDs:
                dressingRoom!.imagesIds?.toIList() ?? const IList.empty(),
          ),
        ],
      ),
    );
  }
}
