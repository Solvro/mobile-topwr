import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../../widgets/my_error_widget.dart";
import "../../../../navigator/utils/navigation_commands.dart";
import "../../../data/models/digital_guide_response.dart";
import "../../../presentation/widgets/digital_guide_nav_link.dart";
import "../data/models/digital_guide_transportation.dart";
import "../data/repository/transportation_repository.dart";

class TransportationExpansionTileContent extends ConsumerWidget {
  const TransportationExpansionTileContent({
    required this.digitalGuideData,
  });
  final DigitalGuideResponse digitalGuideData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTransportationData =
    ref.watch(transportationRepositoryProvider(digitalGuideData));

    return asyncTransportationData.when(
      data: (data) => _TransportationExpansionTileContent(
        transportation: data,
        building: digitalGuideData.id,
      ),
      error: (error, stackTrace) => MyErrorWidget(error),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _TransportationExpansionTileContent extends ConsumerWidget {
  const _TransportationExpansionTileContent({
    required this.transportation,
    required this.building,
  });

  final DigitalGuideTransportation transportation;
  final int building;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: DigitalGuideConfig.heightMedium,
        vertical: DigitalGuideConfig.heightMedium,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DigitalGuideNavLink(
            onTap: () async {
              await ref.navigatePublicTransportDetails(transportation);
            },
            text: context.localize.public_transport,
          ),
          const SizedBox(height: 16),
          DigitalGuideNavLink(
            onTap: () async {
              await ref.navigatePrivateTransportDetails(transportation);
            },
            text: context.localize.private_transport,
          ),
        ],
      ),
    );
  }
}
