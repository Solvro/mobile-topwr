import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../about_us_view/about_us_view.dart";
import "../buildings_view/buildings_view.dart";
import "../department_detail_view/department_detail_view.dart";
import "../departments_view/departments_view.dart";
import "../guide_detail_view/guide_detail_view.dart";
import "../guide_view/guide_view.dart";
import "../home_view/home_view.dart";
import "../navigation_tab_view/navigation_tab_view.dart";
import "../parkings_view/parkings_view.dart";
import "../science_club_detail_view/science_club_detail_view.dart";
import "../science_clubs_view/science_clubs_view.dart";
import "../sks-menu/presentation/sks_menu_screen.dart";
import "../sks_chart/presentation/sks_chart_sheet.dart";
import "root_view.dart";

part "app_router.g.dart";
part "app_router.gr.dart";

class _NoTransitionRoute extends CustomRoute {
  _NoTransitionRoute({
    required super.path,
    required super.page,
  }) : super(
          reverseDurationInMilliseconds: 0,
          durationInMilliseconds: 0,
        );
}

@AutoRouterConfig(replaceInRouteName: "View,Route")
class AppRouter extends RootStackRouter {
  final Ref ref;

  AppRouter({required this.ref});

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: "/",
          page: RootRoute.page,
          children: [
            _NoTransitionRoute(
              path: "",
              page: HomeRoute.page,
            ),
            _NoTransitionRoute(
              path: "buildings/:initialActiveItemId",
              page: BuildingsRoute.page,
            ),
            RedirectRoute(path: "buildings", redirectTo: "buildings/null"),
            _NoTransitionRoute(
              path: "parkings/:initialActiveItemId",
              page: ParkingsRoute.page,
            ),
            RedirectRoute(path: "parkings", redirectTo: "parkings/null"),
            _NoTransitionRoute(
              path: "guide",
              page: GuideRoute.page,
            ),
            _NoTransitionRoute(
              path: "navigation",
              page: NavigationTabRoute.page,
            ),
            AutoRoute(
              path: "aboutUs",
              page: AboutUsRoute.page,
            ),
            AutoRoute(
              path: "guide/:id",
              page: GuideDetailRoute.page,
            ),
          ],
        ),
        AutoRoute(
          path: "/sks-menu",
          page: SksMenuRoute.page,
        ),
        _NoTransitionRoute(
          path: "/departments",
          page: DepartmentsRoute.page,
        ),
        AutoRoute(
          path: "/departments/:id",
          page: DepartmentDetailRoute.page,
        ),
        _NoTransitionRoute(
          path: "/sci-clubs",
          page: ScienceClubsRoute.page,
        ),
        AutoRoute(
          path: "/sci-clubs/:id",
          page: ScienceClubDetailRoute.page,
        ),
      ];
}

@riverpod
Raw<AppRouter> appRouter(Ref ref) {
  return AppRouter(ref: ref);
}
