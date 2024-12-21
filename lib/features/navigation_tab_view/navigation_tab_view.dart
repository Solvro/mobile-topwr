import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../config/ui_config.dart";
import "../../theme/app_theme.dart";
import "../../utils/context_extensions.dart";
import "../analytics/show_feedback_tile.dart";
import "../bottom_nav_bar/bottom_nav_bar_icon_icons.icons.dart";
import "../home_view/widgets/logo_app_bar.dart";
import "../in_app_review/business/in_app_rating_service.dart";
import "../navigator/utils/navigation_commands.dart";
import "widgets/about_the_app_tile.dart";
import "widgets/about_us_tile.dart";
import "widgets/notification_button.dart";
import "widgets/small_tile.dart";

@RoutePage()
class NavigationTabView extends ConsumerWidget {
  const NavigationTabView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final children = [
      const SizedBox(height: NavigationTabViewConfig.universalPadding),
      const AboutUsTile(),
      const ShowFeedbackTile(),
      const SizedBox(height: NavigationTabViewConfig.universalPadding / 3),
      _NavigationRow(
        child1: SmallTileCard(
          onTap: ref.navigateDepartments,
          title: context.localize.departments,
          icon: const Icon(
            BottomNavBarIcons.departments_icon,
            size: NavigationTabViewConfig.navIconSize,
          ),
        ),
        child2: SmallTileCard(
          onTap: InAppRatingService.requestStoreListingReview,
          title: context.localize.leave_a_review,
          icon: Icon(
            Icons.star,
            color: context.colorTheme.gold,
            size: NavigationTabViewConfig.navIconSize,
          ),
        ),
      ),
      _NavigationRow(
        child1: SmallTileCard(
          onTap: ref.navigateToSksMenu,
          title: context.localize.sks_full_name,
          icon: const Icon(
            Icons.restaurant_menu,
            size: NavigationTabViewConfig.navIconSize,
          ),
        ),
        child2: SmallTileCard(
          onTap: ref.navigateScienceClubs,
          title: context.localize.student_organizations,
          icon: const Icon(BottomNavBarIcons.sci_clubs_icon, size: 24),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Text(
          context.localize.rest_header,
          style: context.textTheme.headline,
        ),
      ),
      // TODO(simon-the-shark): reverse this when the settings screen is ready
      // NavigationTile(
      //   onTap: () {},
      //   title: context.localize.settings,
      //   icon: Icons.settings,
      // ),
      const Padding(
        padding:
            EdgeInsets.only(bottom: NavigationTabViewConfig.universalPadding),
        child: AboutTheAppTile(),
      ),
    ];
    return Scaffold(
      appBar: LogoAppBar(
        context,
        logoSize: 40,
        toolbarHeight: 90,
        actions: const [
          NotificationButton(),
        ],
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

class _NavigationRow extends StatelessWidget {
  const _NavigationRow({required this.child1, required this.child2});
  final SmallTileCard child1;
  final SmallTileCard child2;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: child1,
        ),
        const SizedBox(width: NavigationTabViewConfig.universalPadding),
        Expanded(
          child: child2,
        ),
      ],
    );
  }
}
