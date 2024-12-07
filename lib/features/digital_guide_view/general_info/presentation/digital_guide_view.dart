import "package:auto_route/annotations.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../config/ui_config.dart";
import "../../../../gen/assets.gen.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../utils/determine_contact_icon.dart";
import "../../../../widgets/detail_views/contact_section.dart";
import "../../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../../widgets/my_cached_image.dart";
import "../../../../widgets/my_error_widget.dart";
import "../../../../widgets/report_change_button.dart";
import "../data/models/digital_guide_response_extended.dart";
import "../data/repository/digital_guide_repository.dart";
import "widgets/accessibility_button.dart";
import "widgets/digital_guide_data_source_link.dart";
import "widgets/digital_guide_features_section.dart";
import "widgets/headlines_section.dart";

@RoutePage()
class DigitalGuideView extends ConsumerWidget {
  const DigitalGuideView({
    @PathParam("id") required this.id,
  });

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncDigitalGuideData = ref.watch(getDigitalGuideDataProvider(id));
    // question: Should the app bar appear during loading or when there's an error?
    // Now it doesn't, neither does it appear on SKS menu screen
    return asyncDigitalGuideData.when(
      data: _DigitalGuideView.new,
      error: (error, stackTrace) => MyErrorWidget(error),
      // TODO(Bartosh): shimmer loading
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class _DigitalGuideView extends ConsumerWidget {
  const _DigitalGuideView(this.digitalGuideResponseExtended);

  final DigitalGuideResponseExtended digitalGuideResponseExtended;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: DetailViewAppBar(
        title: context.localize.map,
        actions: [
          AccessibilityButton(),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: DigitalGuideConfig.heightSmall),
              MyCachedImage(
                digitalGuideResponseExtended.imageUrl,
              ),
              HeadlinesSection(
                // There is only Polish language translation in external API
                // In the future we must think how to handle multiple translations in UI
                // For now it can be temporarily dealt with in the data layer
                name: digitalGuideResponseExtended
                    .translations.plTranslation.name,
                description: digitalGuideResponseExtended
                    .translations.plTranslation.extendedName,
              ),
              ContactSection(
                list: IList<ContactIconsModel>([
                  ContactIconsModel(
                    text: digitalGuideResponseExtended
                        .translations.plTranslation.address
                        .replaceAll("ulica", "ul."),
                    icon: Assets.svg.contactIcons.compass,
                  ),
                  ContactIconsModel(
                    text: digitalGuideResponseExtended.telephoneNumber,
                    icon: Assets.svg.contactIcons.phone,
                    // TODO(Bartosh): url not working, nothing happens
                    url:
                        "tel:+48${digitalGuideResponseExtended.telephoneNumber.replaceAll("<p>", "").replaceAll("</p>", "")}",
                  ),
                  ContactIconsModel(
                    text: context.localize
                        .storeys(digitalGuideResponseExtended.numberOfStoreys),
                    icon: Assets.svg.contactIcons.storey,
                  ),
                ]),
              ),
              DigitalGuideFeaturesSection(
                digitalGuideResponseExtended: digitalGuideResponseExtended,
              ),
              const SizedBox(height: DigitalGuideConfig.heightMedium),
              DigitalGuideDataSourceLink(),
              ReportChangeButton(),
              const SizedBox(height: DigitalGuideConfig.heightHuge),
            ]),
          ),
        ],
      ),
    );
  }
}
