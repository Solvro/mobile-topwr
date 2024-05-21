import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../features/iparking/api_client/iparking_commands.dart';
import '../features/iparking/widgets/offline_parkings.dart';

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget(this.error, {super.key});
  final Object? error;
  @override
  Widget build(BuildContext context) {
    Logger().e(error.toString());
    return switch (error) {
      ParkingsOfflineException() => const OfflineParkings(),
      _ => Center(
          child: Text(
            error.toString(),
          ),
        )
    };
  }
}
