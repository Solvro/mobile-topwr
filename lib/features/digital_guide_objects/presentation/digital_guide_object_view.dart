import "package:auto_route/auto_route.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../api_base/directus_assets_url.dart";
import "../../../config/ui_config.dart";
import "../../../gen/assets.gen.dart";
import "../../../utils/context_extensions.dart";
import "../../../utils/determine_contact_icon.dart";
import "../../../widgets/detail_views/contact_section.dart";
import "../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../widgets/horizontal_symmetric_safe_area.dart";
import "../../../widgets/my_error_widget.dart";
import "../../../widgets/zoomable_images.dart";
import "../../buildings_view/model/building_model.dart";
import "../../digital_guide/presentation/widgets/accessibility_button.dart";
import "../../digital_guide/presentation/widgets/digital_guide_data_source_link.dart";
import "../../digital_guide/presentation/widgets/digital_guide_loading_view.dart";
import "../../digital_guide/presentation/widgets/headlines_section.dart";
import "../../digital_guide/presentation/widgets/report_change_button.dart";
import "../data/models/digital_guide_object_model.dart";
import "../data/repositories/digital_guide_object_repository.dart";
import "digital_g_objects_featers_list.dart";

@RoutePage()
class DigitalGuideObjectView extends ConsumerWidget {
  const DigitalGuideObjectView({
    @PathParam("id") required this.ourId,
    required this.building,
  });

  final String ourId;
  final BuildingModel building;

  static String localizedOfflineMessage(BuildContext context) {
    return context.localize.my_offline_error_message(
      context.localize.digital_guide_offline,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncDigitalGuideData =
        ref.watch(digitalGuideObjectRepositoryProvider(ourId));
    return asyncDigitalGuideData.when(
      data: (data) {
        return _DigitalGObjectView(
          data.digitalGuideData,
          data.photoUrl,
          building,
        );
      },
      error: (error, stackTrace) {
        return HorizontalSymmetricSafeAreaScaffold(
          appBar: DetailViewAppBar(),
          body: MyErrorWidget(error),
        );
      },
      loading: () => const DigitalGuideLoadingView(),
    );
  }
}

class _DigitalGObjectView extends ConsumerWidget {
  const _DigitalGObjectView(
    this.digitalGuideData,
    this.photoUrl,
    this.building,
  );

  final DigitalGuideObjectModel digitalGuideData;
  final String? photoUrl;
  final BuildingModel building;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgets1 = [
      const SizedBox(height: DigitalGuideConfig.heightSmall),
      SizedBox(
        height: DetailViewsConfig.imageHeight,
        child: ZoomableOptimizedDirectusImage(photoUrl?.directusUrl),
      ),
      HeadlinesSection(
        name: digitalGuideData.translations.pl.name,
        description: "",
      ),
      ContactSection(
        list: IList<ContactIconsModel>([
          ContactIconsModel(
            text: digitalGuideData.translations.pl.address
                .replaceAll("ulica", "ul."),
            icon: Assets.svg.contactIcons.compass,
          ),
        ]),
      ),
      const SizedBox(height: DigitalGuideConfig.heightBig),
    ];

    final widgets2 = [
      const SizedBox(height: DigitalGuideConfig.heightBig),
      DigitalGuideDataSourceLink(),
      ReportChangeButton(),
      const SizedBox(height: DigitalGuideConfig.heightHuge),
    ];

    return HorizontalSymmetricSafeAreaScaffold(
      appBar: DetailViewAppBar(
        actions: [AccessibilityButton()],
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return widgets1[index];
              },
              childCount: widgets1.length,
            ),
          ),
          DigitalGuideObjectsFeaturesSection(
            digitalGuideData: digitalGuideData,
            building: building,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return widgets2[index];
              },
              childCount: widgets2.length,
            ),
          ),
        ],
      ),
    );
  }
}
