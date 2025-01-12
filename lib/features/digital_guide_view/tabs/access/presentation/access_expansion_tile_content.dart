import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../navigator/utils/navigation_commands.dart";
import "../../../../../config/ui_config.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../data/models/digital_guide_response_extended.dart";
import "../../../../../widgets/my_error_widget.dart";
import "../../../presentation/widgets/digital_guide_nav_link.dart";
import "../data/models/access.dart";
import "../data/repository/access_repository.dart";

class AccessExpansionTileContent extends ConsumerWidget {
  const AccessExpansionTileContent({
    required this.digitalGuideResponseExtended,
  });

  final DigitalGuideResponseExtended digitalGuideResponseExtended;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncAccess = ref.watch(AccessRepositoryProvider(digitalGuideResponseExtended.id));
    return asyncAccess.when(
      data: (data) {
        final accessData = data! as List<Access>;
        return _AccessExpansionTileContent(accessData: accessData);
      },
      error: (error, stackTrace) => MyErrorWidget(error),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _AccessExpansionTileContent extends ConsumerWidget {
  const _AccessExpansionTileContent({
    required this.accessData,
  });

  final List<Access> accessData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: DigitalGuideConfig.heightMedium,
        vertical: DigitalGuideConfig.heightMedium,
      ),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: accessData.length,
        itemBuilder: (context, index) {
          final items = [
            context.localize.public_transport,
            context.localize.private_transport,
          ];

          final access = accessData[index];
          return DigitalGuideNavLink(
            onTap: () async {
              if (index == 0) {
                // Navigate to public transport details
                await ref.navigatePublicTransportDetails(access);
              } else if (index == 1) {
                // Navigate to private transport details
                await ref.navigatePrivateTransportDetails(access);
              }
            },
            text: items[index],
          );
        },
      ),
    );
  }
}
