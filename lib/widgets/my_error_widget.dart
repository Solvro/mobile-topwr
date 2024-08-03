import "package:flutter/material.dart";
import "package:logger/logger.dart";

import "../api_base/watch_query_adapter.dart";
import "../features/iparking/api_client/iparking_commands.dart";
import "../features/iparking/widgets/offline_parkings.dart";
import "../features/offline_messages/widgets/grapgql_offline_message.dart";

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget(this.error, {super.key});
  final Object? error;
  @override
  Widget build(BuildContext context) {
    Logger().e(error.toString());
    return switch (error) {
      ParkingsOfflineException() => const OfflineParkings(),
      GqlOfflineException(:final ttlKey) => OfflineGraphQLMessage(ttlKey),
      _ => Center(
          child: Text(
            error.toString(),
          ),
        )
    };
  }
}
