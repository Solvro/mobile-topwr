import "package:flutter/material.dart";
import "package:logger/logger.dart";

import "../api_base/watch_query_adapter.dart";
import "../features/offline_messages/widgets/grapgql_offline_message.dart";
import "../features/parkings_view/api_client/iparking_commands.dart";
import "../features/parkings_view/widgets/offline_parkings_view.dart";

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget(this.error, {super.key});
  final Object? error;
  @override
  Widget build(BuildContext context) {
    Logger().e(error.toString());
    return switch (error) {
      ParkingsOfflineException() => const OfflineParkingsView(),
      GqlOfflineException(:final ttlKey) => OfflineGraphQLMessage(ttlKey),
      _ => Center(
          child: Text(
            error.toString(),
          ),
        )
    };
  }
}
