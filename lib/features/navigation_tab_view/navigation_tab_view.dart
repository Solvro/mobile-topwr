import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";

import "../../config/ui_config.dart";
import "../../theme/app_theme.dart";
import "../../utils/context_extensions.dart";
import "../analytics/show_feedback_tile.dart";
import "../bottom_nav_bar/bottom_nav_bar_icon_icons.icons.dart";
import "../home_view/widgets/logo_app_bar.dart";
import "widgets/about_us_tile.dart";
import "widgets/navigation_tile.dart";
import "widgets/small_tile.dart";

@RoutePage()
class NavigationTabView extends StatelessWidget {
  const NavigationTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final children = [
      const SizedBox(height: NavigationTabViewConfig.universalPadding),
      const AboutUsTile(),
      const ShowFeedbackTile(),
      const SizedBox(height: NavigationTabViewConfig.universalPadding / 3),
      Row(
        children: [
          Expanded(
            child: SmallTileCard(
              onTap: () {},
              title: context.localize.departments,
              icon: const Icon(BottomNavBarIcon.faculty_icon),
            ),
          ),
          const SizedBox(width: NavigationTabViewConfig.universalPadding),
          Expanded(
            child: SmallTileCard(
              onTap: () {},
              title: context.localize.leave_a_review,
              icon: const Icon(Icons.star, color: Color(0xFFFFDF00), size: 30),
            ),
          ),
        ],
      ),
      Row(
        children: [
          Expanded(
            child: SmallTileCard(
              onTap: () {},
              title: context.localize.sks_full_name,
              icon: const Icon(Icons.fastfood_rounded, size: 30),
            ),
          ),
          const SizedBox(width: NavigationTabViewConfig.universalPadding),
          Expanded(
            child: SmallTileCard(
              onTap: () {},
              title: context.localize.guide,
              icon: const Icon(Icons.book, size: 30),
            ),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Text(
          context.localize.rest_header,
          style: context.textTheme.headline,
        ),
      ),
      NavigationTile(
        onTap: () {},
        title: context.localize.settings,
        icon: Icons.settings,
      ),
      NavigationTile(
        onTap: () {},
        title: context.localize.about_the_app,
        icon: Icons.info,
      ),
      const SizedBox.shrink(),
    ];
    return Scaffold(
      appBar: LogoAppBar(
        context,
        logoSize: 40,
        toolbarHeight: 80,
      ),
      body: ListView.separated(
        padding: GuideViewConfig.gridPadding,
        itemBuilder: (context, index) => children[index],
        separatorBuilder: (context, index) =>
            const SizedBox(height: NavigationTabViewConfig.universalPadding),
        itemCount: children.length,
      ),
    );
  }
}
