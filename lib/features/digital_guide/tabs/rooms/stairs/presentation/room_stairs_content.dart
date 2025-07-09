import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../../config/ui_config.dart";
import "../../../../../../utils/context_extensions.dart";
import "../../../../../../widgets/my_error_widget.dart";
import "../../../../presentation/widgets/accessibility_profile_card.dart";
import "../../../../presentation/widgets/bullet_list.dart";
import "../business/room_stairs_accessibility_comments_manager.dart";
import "../models/room_stairs_response.dart";
import "../repository/room_stairs_repository.dart";

class RoomStairsContent extends ConsumerWidget {
  const RoomStairsContent({required this.roomStairsId});

  final int roomStairsId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncRoomStairs = ref.watch(roomStairsRepositoryProvider(roomStairsId));

    return asyncRoomStairs.when(
      data: (roomStairsData) => _RoomStairsContent(roomStairsResponse: roomStairsData),
      error: (error, stackTrace) => MyErrorWidget(error, stackTrace: stackTrace),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class _RoomStairsContent extends ConsumerWidget {
  const _RoomStairsContent({required this.roomStairsResponse});

  final RoomStairsResponse roomStairsResponse;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final comments = roomStairsResponse.translations.pl;

    final roomStairsComments = [
      roomStairsResponse.translations.pl.location,
      "${context.localize.room_stairs_is_nonslip_surface(roomStairsResponse.isNonslipSurface.toLowerCase())} ${comments.isNonslipSurfaceComment}",
    ].lock;

    return Padding(
      padding: DigitalGuideConfig.symetricalPaddingBig.copyWith(top: 0),
      child: Column(
        children: [
          BulletList(items: roomStairsComments),
          AccessibilityProfileCard(
            accessibilityCommentsManager: RoomStairsAccessibilityCommentsManager(
              roomStairsResponse: roomStairsResponse,
              l10n: context.localize,
            ),
          ),
        ],
      ),
    );
  }
}
