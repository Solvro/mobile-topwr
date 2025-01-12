import "package:auto_route/auto_route.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../presentation/widgets/accessibility_button.dart";
import "../../../presentation/widgets/bullet_list.dart";
import "../../../presentation/widgets/digital_guide_image.dart";
import "../../../presentation/widgets/digital_guide_nav_link.dart";
import "../data/models/access.dart";

@RoutePage()
class PublicTransportDetailView extends ConsumerWidget {
  const PublicTransportDetailView({
    required this.access,
  });

  final Access access;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Widget> widgets = [
      const SizedBox(height: DigitalGuideConfig.heightMedium),
      BulletList(
        items: [
          access.translations.plTranslation.nearestDisabledParkingSpaces,
          access.translations.plTranslation.location,
        ].lock,
      ),
      const SizedBox(height: DigitalGuideConfig.heightBig),
    ];

    return Scaffold(
      appBar: DetailViewAppBar(
        actions: [AccessibilityButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: DigitalGuideConfig.heightBig,
        ),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => widgets[index],
                childCount: widgets.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
