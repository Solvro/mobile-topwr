import "package:auto_route/annotations.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/ui_config.dart";
import "../../../gen/assets.gen.dart";
import "../../../utils/context_extensions.dart";
import "../../../utils/determine_contact_icon.dart";
import "../../../widgets/detail_views/contact_section.dart";
import "../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../widgets/my_cached_image.dart";
import "../../../widgets/my_error_widget.dart";
import "../../../widgets/report_change_button.dart";
import "../data/models/digital_guide_response.dart";
import "../data/repository/digital_guide_repository.dart";
import "../data/repository/image_repository.dart";
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
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class _DigitalGuideView extends ConsumerWidget {
  const _DigitalGuideView(this.digitalGuideResponse);

  final DigitalGuideResponse digitalGuideResponse;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncImageResponse =
        ref.watch(getImageDataProvider(digitalGuideResponse.images[0]));

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
              asyncImageResponse.when(
                data: (imageResponseData) => MyCachedImage(
                  imageResponseData.imageUrl,
                ),
                
                // Image.network(
                //   imageResponseData.imageUrl,
                //   fit: BoxFit.fitWidth,
                // ),
                loading: () => const Center(child: CircularProgressIndicator()),
                // To-do nice error
                error: (error, stack) => Text("Error loading images: $error"),
              ),
              HeadlinesSection(
                name: digitalGuideResponse.translations.plTranslation.name,
                description: digitalGuideResponse.translations.plTranslation.extendedName,
              ),
              ContactSection(
                list: IList<ContactIconsModel>([
                  ContactIconsModel(
                    text: digitalGuideResponse.translations.plTranslation.address
                        .replaceAll("ulica", "ul."),
                    icon: Assets.svg.contactIcons.compass,
                  ),
                  ContactIconsModel(
                    text: digitalGuideResponse.telephoneNumber,
                    icon: Assets.svg.contactIcons.phone,
                    // To-do url not working, nothing happens
                    url:
                        "tel:+48${digitalGuideResponse.telephoneNumber.replaceAll("<p>", "").replaceAll("</p>", "")}",
                  ),
                  ContactIconsModel(
                    text: context.localize
                        .storeys(digitalGuideResponse.numberOfStoreys),
                    icon: Assets.svg.contactIcons.storey,
                  ),
                ]),
              ),
              DigitalGuideFeaturesSection(
                digitalGuideResponse: digitalGuideResponse,
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
