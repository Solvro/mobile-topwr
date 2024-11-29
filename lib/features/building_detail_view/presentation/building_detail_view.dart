import "dart:io";

import "package:auto_route/annotations.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../../../gen/assets.gen.dart";

import "../../../utils/context_extensions.dart";
import "../../../utils/determine_contact_icon.dart";
import "../../../widgets/change_report_button.dart";
import "../../../widgets/detail_views/contact_section.dart";
import "../../../widgets/detail_views/detail_view_app_bar.dart";
import "widgets/accessible_button.dart";
import "widgets/building_data_source_link.dart";
import "widgets/building_features_section.dart";
import "widgets/headlines_section.dart";

@RoutePage()
class BuildingDetailView extends ConsumerWidget {
  const BuildingDetailView({
    @PathParam("id") required this.id
  });

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _BuildingDetailView();
  }

}

class _BuildingDetailView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    debugPrint("BuildingDetailView");
    return Scaffold(
      appBar: DetailViewAppBar(
        title: context.localize.map,
        actions: [
          AccessibleButton(),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          //Image.network("https://cocktails.solvro.pl/images/cocktails/long-island-tea.png"),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 8),
              Image.network("https://dummyimage.com/640x360/000/fff", fit: BoxFit.fitWidth),
              const HeadlinesSection(name: "Budynek C-2", description: "Budynek imienia profesora Wiesławia Barwicza"),
              ContactSection(
                title: "Siuuu",
                list: IList<ContactIconsModel>([
                  ContactIconsModel(text: "Kampus Glówny", icon: Assets.svg.contactIcons.compass),
                  ContactIconsModel(text: "ul. Janiszewskiego 11-17, 54-152 Wrocław", icon: Assets.svg.contactIcons.compass),
                  ContactIconsModel(text: "(+48) 71 320 62 30", icon: Assets.svg.contactIcons.phone),
                  ContactIconsModel(text: "5 pięter", icon: Assets.svg.contactIcons.storey),
                ]),
              ),
              BuildingFeaturesSection(),
              const SizedBox(height: 16),
              BuildingDataSourceLink(),
              ChangeReportButton(),
            ]),
          ),
        ],
      ),
    );
  }
}
