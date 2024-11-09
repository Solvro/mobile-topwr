import "dart:core";

import "package:auto_route/annotations.dart";
import "package:flutter/material.dart";

import "../../config/ui_config.dart";
import "../../utils/context_extensions.dart";
import "../../widgets/detail_views/detail_view_app_bar.dart";
import "../home_view/widgets/paddings.dart";
import "widgets/sks_menu_data_source_link.dart";
import "widgets/sks_menu_header.dart";
import "widgets/sks_menu_section.dart";

@RoutePage()
class SksMenuView extends StatelessWidget {
  const SksMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DetailViewAppBar(context, title: context.localize.home_screen),
      body: ListView(
        children: [
          // TODO(mikolaj-jalocha): Pass current data here
          const SksMenuHeader(
            dateTimeOfLastUpdate: "2024-11-09T15:26:39Z",
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: HomeViewConfig.paddingMedium,
            ),
            child: MediumHorizontalPadding(child: SksMenuSection()),
          ),
          const SksMenuDataSourceLink(),
          const SizedBox(
            height: ScienceClubsViewConfig.mediumPadding,
          ),
        ],
      ),
    );
  }
}
