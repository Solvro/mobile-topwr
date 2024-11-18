import "package:auto_route/auto_route.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";

import "../analytics/show_feedback_tile.dart";
import "../bottom_nav_bar/bottom_nav_bar_icon_icons.icons.dart";
import "../guide_view/widgets/guide_grid.dart";
import "../home_view/widgets/logo_app_bar.dart";
import "widgets/about_us_tile.dart";
import "widgets/small_tile.dart";

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
          Row(
            children: [
              // Expanded(
              //   child: SmallTileCard(
              //     title: "Zgłos błąd lub sugestię",
              //     icon: Icon(Icons.bug_report),
              //   ),
              // ),

              Expanded(
                child: SmallTileCard(
                  onTap: () {},
                  title: "Wydziały",
                  icon: const Icon(BottomNavBarIcon.faculty_icon),
                ),
              ),
              const SizedBox(width: 8),

              Expanded(
                child: SmallTileCard(
                  onTap: () {},
                  title: "Oceń aplikację",
                  icon: const Icon(
                    Icons.star,
                    color: Color(0xFFFFDF00),
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
          const ShowFeedbackTile(),
        ].lock,
      ),
    );
  }
}
