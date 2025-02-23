import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../../config/ui_config.dart";
import "../../../../../../widgets/my_error_widget.dart";
import "../../../../presentation/widgets/bullet_list.dart";
import "../models/room_stairs_response.dart";
import "../repository/room_stairs_repository.dart";
import "../utils/room_stairs_comment_list.dart";

class RoomStairsContent extends ConsumerWidget {
  const RoomStairsContent({required this.roomStairsId});

  final int roomStairsId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncRoomStairs =
        ref.watch(roomStairsRepositoryProvider(roomStairsId));

    return asyncRoomStairs.when(
      data: (roomStairsData) => _RoomStairsContent(
        roomStairsResponse: roomStairsData,
      ),
      error: (error, stackTrace) => MyErrorWidget(error),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _RoomStairsContent extends ConsumerWidget {
  const _RoomStairsContent({required this.roomStairsResponse});

  final RoomStairsResponse roomStairsResponse;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomStairsComments =
        context.getRoomStairsCommentsList(roomStairsResponse);

    return Padding(
      padding: DigitalGuideConfig.symetricalPaddingBig.copyWith(top: 0),
      child: Column(
        children: [
          BulletList(items: roomStairsComments),
          const SizedBox(
            height: DigitalGuideConfig.heightBig,
          ),
        ],
      ),
    );
  }
}
