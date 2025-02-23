import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../../config/ui_config.dart";
import "../../../../../../widgets/my_error_widget.dart";
import "../../../../presentation/widgets/bullet_list.dart";
import "../models/room_platforms_response.dart";
import "../repository/room_platforms_repository.dart";
import "../room_platforms_comment_list.dart";

class RoomPlatformsContent extends ConsumerWidget {
  const RoomPlatformsContent({required this.platformId});

  final int platformId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncRoomPlatforms =
        ref.watch(roomPlatformsRepositoryProvider(platformId));

    return asyncRoomPlatforms.when(
      data: (roomPlatformsData) => _RoomPlatformsContent(
        roomPlatformsResponse: roomPlatformsData,
      ),
      error: (error, stackTrace) => MyErrorWidget(error),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _RoomPlatformsContent extends ConsumerWidget {
  const _RoomPlatformsContent({required this.roomPlatformsResponse});

  final RoomPlatformsResponse roomPlatformsResponse;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomPlatformsComment =
        context.getRoomPlatformsCommentsList(roomPlatformsResponse);

    return Padding(
      padding: DigitalGuideConfig.symetricalPaddingBig.copyWith(top: 0),
      child: Column(
        children: [
          BulletList(items: roomPlatformsComment),
          const SizedBox(
            height: DigitalGuideConfig.heightBig,
          ),
        ],
      ),
    );
  }
}
