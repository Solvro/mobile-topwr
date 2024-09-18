import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../config/transitions.dart";
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
import "utils/tab_bar_transition.dart";

part "app_router.g.dart";
part "app_router.gr.dart";

@AutoRouterConfig(replaceInRouteName: "View,Route")
class AppRouter extends _$AppRouter {
  final Ref ref;

  AppRouter({required this.ref});

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: "/",
          page: RootRoute.page,
          children: [
            CustomRoute(
              path: "",
              page: HomeRoute.page,
              durationInMilliseconds: TransitionsConfig.durationInMiliseconds,
              reverseDurationInMilliseconds:
                  TransitionsConfig.durationInMiliseconds,
              transitionsBuilder: ref.tabBarTransitionBuilder(HomeRoute.name),
            ),
            CustomRoute(
              path: "buildings",
              page: BuildingsRoute.page,
              durationInMilliseconds: TransitionsConfig.durationInMiliseconds,
              reverseDurationInMilliseconds:
                  TransitionsConfig.durationInMiliseconds,
              transitionsBuilder:
                  ref.tabBarTransitionBuilder(BuildingsRoute.name),
            ),
            CustomRoute(
              path: "parkings",
              page: ParkingsRoute.page,
              durationInMilliseconds: TransitionsConfig.durationInMiliseconds,
              reverseDurationInMilliseconds:
                  TransitionsConfig.durationInMiliseconds,
              transitionsBuilder:
                  ref.tabBarTransitionBuilder(ParkingsRoute.name),
            ),
            CustomRoute(
              path: "departments",
              page: DepartmentsRoute.page,
              durationInMilliseconds: TransitionsConfig.durationInMiliseconds,
              reverseDurationInMilliseconds:
                  TransitionsConfig.durationInMiliseconds,
              transitionsBuilder:
                  ref.tabBarTransitionBuilder(DepartmentsRoute.name),
            ),
            AutoRoute(
              path: "departments/:id",
              page: DepartmentDetailRoute.page,
            ),
            CustomRoute(
              path: "sci-clubs",
              page: ScienceClubsRoute.page,
              durationInMilliseconds: TransitionsConfig.durationInMiliseconds,
              reverseDurationInMilliseconds:
                  TransitionsConfig.durationInMiliseconds,
              transitionsBuilder:
                  ref.tabBarTransitionBuilder(ScienceClubsRoute.name),
            ),
            AutoRoute(
              path: "sci-clubs/:id",
              page: ScienceClubDetailRoute.page,
            ),
            CustomRoute(
              path: "guide",
              page: GuideRoute.page,
              durationInMilliseconds: TransitionsConfig.durationInMiliseconds,
              reverseDurationInMilliseconds:
                  TransitionsConfig.durationInMiliseconds,
              transitionsBuilder: ref.tabBarTransitionBuilder(GuideRoute.name),
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
