import "package:auto_route/auto_route.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";

import "../analytics/show_feedback_tile.dart";
import "../guide_view/widgets/guide_grid.dart";
import "../home_view/widgets/logo_app_bar.dart";
import "widgets/about_us_tile.dart";

@RoutePage()
class NavigationTabView extends StatelessWidget {
  const NavigationTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LogoAppBar(
        context,
      ),
      body: GuideGrid(
        children: [
          const AboutUsTile(),
          const ShowFeedbackTile(),
        ].lock,
      ),
    );
  }
}
