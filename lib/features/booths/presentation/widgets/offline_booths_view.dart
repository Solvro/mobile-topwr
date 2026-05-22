import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../utils/context_extensions.dart";
import "../../../../widgets/general_offline_message.dart";
import "../../data/repository/booths_repository.dart";

class OfflineBoothsView extends ConsumerWidget {
  const OfflineBoothsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OfflineMessage(
      context.localize.offline_error_message,
      onRefresh: () => ref.refresh(boothsRepositoryProvider),
    );
  }
}
