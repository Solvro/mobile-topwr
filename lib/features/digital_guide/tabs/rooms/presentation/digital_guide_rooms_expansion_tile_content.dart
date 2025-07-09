import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../../widgets/my_error_widget.dart";
import "../../../data/models/digital_guide_response.dart";
import "../domain/digital_guide_rooms_use_cases.dart";
import "digital_guide_room_level.dart";

class DigitalGuideRoomExpansionTileContent extends ConsumerWidget {
  const DigitalGuideRoomExpansionTileContent({required this.digitalGuideResponse});

  final DigitalGuideResponse digitalGuideResponse;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final levelsWithRooms = ref.watch(getLevelsWithRoomsUseCaseProvider(digitalGuideResponse));
    return levelsWithRooms.when(
      data: (data) => _DigitalGuideRoomExpansionTileContent(levelsWithRooms: data),
      error: (error, stackTrace) => MyErrorWidget(error, stackTrace: stackTrace),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class _DigitalGuideRoomExpansionTileContent extends ConsumerWidget {
  const _DigitalGuideRoomExpansionTileContent({required this.levelsWithRooms});

  final IList<LevelWithRooms> levelsWithRooms;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: DigitalGuideConfig.paddingMedium,
        vertical: DigitalGuideConfig.paddingMedium,
      ),
      child: Material(
        color: context.colorTheme.greyLight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: levelsWithRooms.map((level) {
            return DigitalGuideRoomLevel(level: level.level, rooms: level.rooms);
          }).toList(),
        ),
      ),
    );
  }
}
