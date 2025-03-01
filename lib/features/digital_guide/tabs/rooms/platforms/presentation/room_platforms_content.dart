import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../../config/ui_config.dart";
import "../../../../../../utils/context_extensions.dart";
import "../../../../../../widgets/my_error_widget.dart";
import "../../../../presentation/widgets/accessibility_profile_card.dart";
import "../../../../presentation/widgets/bullet_list.dart";
import "../business/room_platforms_accessibility_comments_manager.dart";
import "../models/room_platforms_response.dart";
import "../repository/room_platforms_repository.dart";

class RoomPlatformsContent extends ConsumerWidget {
  const RoomPlatformsContent({required this.platformId});

  final int platformId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncRoomPlatforms = ref.watch(roomPlatformsRepositoryProvider(platformId));

    return asyncRoomPlatforms.when(
      data: (roomPlatformsData) => _RoomPlatformsContent(roomPlatformsResponse: roomPlatformsData),
      error: (error, stackTrace) => MyErrorWidget(error),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class _RoomPlatformsContent extends ConsumerWidget {
  const _RoomPlatformsContent({required this.roomPlatformsResponse});

  final RoomPlatformsResponse roomPlatformsResponse;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomPlatformsComment = [
      roomPlatformsResponse.translations.pl.location,
      roomPlatformsResponse.translations.pl.comment,
    ].toIList();


    return Padding(
      padding: DigitalGuideConfig.symetricalPaddingBig.copyWith(top: 0),
      child: Column(

        children: [
          BulletList(items: roomPlatformsComment),
          AccessibilityProfileCard(
            accessibilityCommentsManager:
                RoomPlatformsAccessibilityCommentsManager(
              roomPlatformsResponse: roomPlatformsResponse,
              l10n: context.localize,
            ),
          ),
        ],
      ),
    );
  }
}
