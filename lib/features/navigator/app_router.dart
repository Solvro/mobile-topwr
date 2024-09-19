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
import "../parkings_view/parkings_view.dart";
import "../science_club_detail_view/science_club_detail_view.dart";
import "../science_clubs_view/science_clubs_view.dart";
import "root_view.dart";
import "utils/no_transition_route.dart";

part "app_router.g.dart";
part "app_router.gr.dart";

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
            NoTransitionRoute(
              path: "",
              page: HomeRoute.page,
            ),
            NoTransitionRoute(
              path: "buildings",
              page: BuildingsRoute.page,
            ),
            NoTransitionRoute(
              path: "parkings",
              page: ParkingsRoute.page,
            ),
            NoTransitionRoute(
              path: "departments",
              page: DepartmentsRoute.page,
            ),
            AutoRoute(
              path: "departments/:id",
              page: DepartmentDetailRoute.page,
            ),
            NoTransitionRoute(
              path: "sci-clubs",
              page: ScienceClubsRoute.page,
            ),
            AutoRoute(
              path: "sci-clubs/:id",
              page: ScienceClubDetailRoute.page,
            ),
            NoTransitionRoute(
              path: "guide",
              page: GuideRoute.page,
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
      ];
}

@riverpod
AppRouter appRouter(AppRouterRef ref) {
  return AppRouter(ref: ref);
}
