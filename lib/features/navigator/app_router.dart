import "package:auto_route/auto_route.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../config/transitions.dart";
import "../buildings_map/buildings_view.dart";
import "../department_details/department_details.dart";
import "../departments_tab/departments_tab.dart";
import "../guide/guide_view_template.dart";
import "../guide/widgets/about_us/about_us_tab.dart";
import "../home_view/home_view.dart";
import "../iparking/parking_view.dart";
import "../student_research_group_tab/scientific_circles_tab.dart";
import "../study_circle_details/study_circle_details.dart";
import "root_page.dart";
import "utils/tab_bar_transition.dart";

part "app_router.g.dart";
part "app_router.gr.dart";

@AutoRouterConfig(replaceInRouteName: "Page|Screen|View|Tab,Route")
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
              path: "map",
              page: BuildingMapRoute.page,
              durationInMilliseconds: TransitionsConfig.durationInMiliseconds,
              reverseDurationInMilliseconds:
                  TransitionsConfig.durationInMiliseconds,
              transitionsBuilder:
                  ref.tabBarTransitionBuilder(BuildingMapRoute.name),
            ),
            CustomRoute(
              path: "parkings",
              page: ParkingsMapRoute.page,
              durationInMilliseconds: TransitionsConfig.durationInMiliseconds,
              reverseDurationInMilliseconds:
                  TransitionsConfig.durationInMiliseconds,
              transitionsBuilder:
                  ref.tabBarTransitionBuilder(ParkingsMapRoute.name),
            ),
            CustomRoute(
              path: "departments",
              page: DepartmentRoute.page,
              durationInMilliseconds: TransitionsConfig.durationInMiliseconds,
              reverseDurationInMilliseconds:
                  TransitionsConfig.durationInMiliseconds,
              transitionsBuilder:
                  ref.tabBarTransitionBuilder(DepartmentRoute.name),
            ),
            CustomRoute(
              path: "departments/:id",
              page: DepartmentDetailsRoute.page,
              durationInMilliseconds:
                  TransitionsConfig.detailDurationInMiliseconds,
              reverseDurationInMilliseconds:
                  TransitionsConfig.detailDurationInMiliseconds,
              transitionsBuilder: TransitionsConfig.detailViewBuilder,
            ),
            CustomRoute(
              path: "sci-clubs",
              page: ScientificCirclesRoute.page,
              durationInMilliseconds: TransitionsConfig.durationInMiliseconds,
              reverseDurationInMilliseconds:
                  TransitionsConfig.durationInMiliseconds,
              transitionsBuilder:
                  ref.tabBarTransitionBuilder(ScientificCirclesRoute.name),
            ),
            CustomRoute(
              path: "sci-clubs/:id",
              page: StudyCircleDetailsRoute.page,
              durationInMilliseconds:
                  TransitionsConfig.detailDurationInMiliseconds,
              reverseDurationInMilliseconds:
                  TransitionsConfig.detailDurationInMiliseconds,
              transitionsBuilder: TransitionsConfig.detailViewBuilder,
            ),
            CustomRoute(
              path: "guide",
              page: GuideRouteTemplate.page,
              durationInMilliseconds: TransitionsConfig.durationInMiliseconds,
              reverseDurationInMilliseconds:
                  TransitionsConfig.durationInMiliseconds,
              transitionsBuilder:
                  ref.tabBarTransitionBuilder(GuideRouteTemplate.name),
            ),
            CustomRoute(
              path: "aboutUs",
              page: AboutUsRoute.page,
              durationInMilliseconds:
                  TransitionsConfig.detailDurationInMiliseconds,
              reverseDurationInMilliseconds:
                  TransitionsConfig.detailDurationInMiliseconds,
              transitionsBuilder: TransitionsConfig.detailViewBuilder,
            ),
          ],
        ),
      ];
}

@riverpod
AppRouter appRouter(AppRouterRef ref) {
  return AppRouter(ref: ref);
}
