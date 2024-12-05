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
import "../../../widgets/report_change_button.dart";
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

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncDigitalGuideData = ref.watch(getDigitalGuideDataProvider(101));
    // question: do we want app bar to appear while loading and error?
    // Not it doesn't. Neither on SKS menu screen
    return asyncDigitalGuideData.when(
      data: (digitalGuideData) => _DigitalGuideView(),
      error: (error, stackTrace) => Text("API error occured: $error"),
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator(),),
      ),
    );
  }
}

class _DigitalGuideView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              Image.network(
                "https://dummyimage.com/640x360/000/fff",
                fit: BoxFit.fitWidth,
              ),
              const HeadlinesSection(
                name: "Budynek C-2",
                description: "Budynek imienia profesora Wiesławia Barwicza",
              ),
              ContactSection(
                title: "Siuuu",
                list: IList<ContactIconsModel>([
                  ContactIconsModel(
                    text: "Kampus Glówny",
                    icon: Assets.svg.contactIcons.compass,
                  ),
                  ContactIconsModel(
                    text: "ul. Janiszewskiego 11-17, 54-152 Wrocław",
                    icon: Assets.svg.contactIcons.compass,
                  ),
                  ContactIconsModel(
                    text: "(+48) 71 320 62 30",
                    icon: Assets.svg.contactIcons.phone,
                    url: "tel:+48713206230",
                  ),
                  ContactIconsModel(
                    text: "5 pięter",
                    icon: Assets.svg.contactIcons.storey,
                  ),
                ]),
              ),
              DigitalGuideFeaturesSection(),
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
