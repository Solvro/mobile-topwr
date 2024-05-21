import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/app_theme.dart';
import '../../../theme/iparking_theme.dart';
import '../../../utils/context_extensions.dart';
import '../../../widgets/my_text_button.dart';
import '../repositories/parkings_repo.dart';

class OfflineParkings extends StatelessWidget {
  const OfflineParkings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
          child: Text(
            context.localize.offlineParkings,
            style: context.iParkingTheme.subtitle
                .copyWith(
                  color: context.colorTheme.blackMirage,
                )
                .withoutShadows,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.wifi_off_outlined,
            size: 30,
            color: context.colorTheme.blueAzure,
          ),
        ),
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? _) =>
              MyTextButton(
            actionTitle: context.localize.refresh,
            onClick: () => ref.refresh(parkingsRepoProvider),
          ),
        ),
      ],
    );
  }
}
