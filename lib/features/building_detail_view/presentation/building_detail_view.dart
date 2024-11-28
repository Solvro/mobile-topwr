import "dart:io";

import "package:auto_route/annotations.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:path_provider/path_provider.dart";
import "package:topwr/widgets/detail_views/contact_section.dart";

import "../../../utils/context_extensions.dart";
import "../../../utils/determine_contact_icon.dart";
import "../../../widgets/change_report_button.dart";
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
              Image.network('https://via.placeholder.com/640x360', fit: BoxFit.fitWidth),
              const HeadlinesSection(name: "Budynek C-2", description: "Budynek imienia profesora Wiesławia Barwicza"),
              ContactSection(
                title: "Siuuu",
                list: IList<ContactIconsModel>([
                  ContactIconsModel(text: "Kampus Glówny"),
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
