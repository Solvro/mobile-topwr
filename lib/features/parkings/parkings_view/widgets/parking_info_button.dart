import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../config/map_view_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../widgets/my_alert_dialog.dart";
import "../repository/parking_info_repository.dart";

class ParkingInfoButton extends ConsumerWidget {
  const ParkingInfoButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(right: MapViewBottomSheetConfig.horizontalPadding - 12),
      child: IconButton(
        icon: Icon(Icons.info, color: context.colorScheme.primary),
        onPressed: () => _onPressed(context, ref),
        style: IconButton.styleFrom(padding: const EdgeInsets.all(12)),
        tooltip: context.localize.parking_info_button_tooltip,
      ),
    );
  }

  Future<void> _onPressed(BuildContext context, WidgetRef ref) async {
    final parkingInfo = await ref.read(parkingInfoRepositoryProvider.future);
    if (!context.mounted) return;
    await showCustomDialog(
      context: context,
      onConfirmTapped: null,
      confirmText: "",
      dialogSemantics: context.localize.parking_info_dialog_semantics,
      dialogContent: Text(
        parkingInfo.message,
        style: context.textTheme.bodyLarge,
        textScaler: context.textScaler.clamp(maxScaleFactor: 2),
      ),
    );
  }
}
