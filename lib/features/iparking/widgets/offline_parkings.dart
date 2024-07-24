import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../utils/context_extensions.dart";
import "../../offline_messages/widgets/general_offline_message.dart";
import "../repositories/parkings_repo.dart";

class OfflineParkings extends ConsumerWidget {
  const OfflineParkings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OfflineMessage(
      context.localize.offlineParkings,
      onRefresh: () => ref.refresh(parkingsRepoProvider),
    );
  }
}
