import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../gen/assets.gen.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../presentation/widgets/accessibility_button.dart";
import "../../../presentation/widgets/accessibility_profile_card.dart";
import "../../../presentation/widgets/bullet_list.dart";
import "../../../presentation/widgets/digital_guide_nav_link.dart";
import "../../../presentation/widgets/digital_guide_photo_row.dart";
import "../data/business/entraces_response_operations.dart";
import "../data/business/formatting_utils.dart";
import "../data/models/digital_guide_entrace.dart";

@RoutePage()
class DigitalGuideEntranceDetailsView extends ConsumerWidget {
  const DigitalGuideEntranceDetailsView({required this.entrance});

  final DigitalGuideEntrace entrance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Przykładowe dane z JSON (zastąp danymi z twojego modelu)
    final widgets = [
      Text(
        entrance.translations.pl.name ?? "",
        style: context.textTheme.title.copyWith(fontSize: 24),
      ),
      const SizedBox(height: DigitalGuideConfig.heightMedium),
      BulletList(
        items: getNonNullableList([
          formatBool(key: "isMain", value: entrance.isMain),
          formatBool(key: "isAccessible", value: entrance.isAccessible),
          "${formatBool(key: "isForPersonel", value: entrance.isForPersonel)}. ${entrance.translations.pl.location}",
          "${formatBool(key: "isLit", value: entrance.isLit)}. ${entrance.translations.pl.isLitComment}",
          formatBool(
              key: "isProtectionFromWeather",
              value: entrance.isProtectionFromWeather),
          formatBool(key: "isEmergencyExit", value: entrance.isEmergencyExit),
          formatBool(
            key: "isBuildingMarkedInEn",
            value: entrance.isBuildingMarkedInEn,
          ),
          "${formatBool(key: "areBenches", value: entrance.areBenches)}. ${entrance.translations.pl.areBenchesComment}",
        ]),
      ),
      const SizedBox(height: DigitalGuideConfig.heightBig),
      AccessibilityProfileCard(
        items: context.getEntranceCommentsList(entrance),
        icon: Assets.svg.digitalGuide.accessibilityAlerts.blindProfile,
      ),
      const SizedBox(height: DigitalGuideConfig.heightBig),
      DigitalGuideNavLink(
        onTap: () {},
        text: context.localize.doors,
      ),
      const SizedBox(height: DigitalGuideConfig.heightBig),
      DigitalGuidePhotoRow(
        imagesIDs: entrance.imagesIndices,
      ),
      const SizedBox(height: DigitalGuideConfig.heightMedium),
      DigitalGuideNavLink(
        onTap: () {},
        text: "Zobacz wszystkie ${entrance.imagesIndices.length} zdjęć",
      ),
    ];

    return Scaffold(
      appBar: DetailViewAppBar(
        actions: [AccessibilityButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(DigitalGuideConfig.paddingMedium),
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widgets.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => widgets[index],
        ),
      ),
    );
  }
}
