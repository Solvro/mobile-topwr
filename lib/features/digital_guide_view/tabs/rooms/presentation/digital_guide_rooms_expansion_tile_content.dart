import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../widgets/my_error_widget.dart";
import "../../../../navigator/utils/navigation_commands.dart";
import "../../../data/models/digital_guide_response.dart";
import "../../../presentation/widgets/digital_guide_nav_link.dart";
import "../data/models/digital_guide_room.dart";
import "../data/repository/rooms_repository.dart";

class DigitalGuideRoomExpansionTileContent extends ConsumerWidget {
  const DigitalGuideRoomExpansionTileContent({
    required this.digitalGuideResponse,
  });

  final DigitalGuideResponse digitalGuideResponse;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomsInBuilding =
        ref.watch(roomsRepositoryProvider(digitalGuideResponse));
    return roomsInBuilding.when(
      data: (data) => _DigitalGuideRoomExpansionTileContent(rooms: data),
      error: (error, _) => MyErrorWidget(error),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _DigitalGuideRoomExpansionTileContent extends ConsumerWidget {
  const _DigitalGuideRoomExpansionTileContent({required this.rooms});

  final IList<DigitalGuideRoom> rooms;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: DigitalGuideConfig.paddingMedium,
        vertical: DigitalGuideConfig.paddingMedium,
      ),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => const SizedBox(
          height: DigitalGuideConfig.heightMedium,
        ),
        itemCount: rooms.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => DigitalGuideNavLink(
          onTap: () async {
            await ref.navigateRoomDetails(
              rooms[index],
            );
          },
          text: rooms[index].translations.pl.name,
        ),
      ),
    );
  }
}
