import "package:auto_route/auto_route.dart";

class NoTransitionRoute extends CustomRoute {
  NoTransitionRoute({
    required super.path,
    required super.page,
  }) : super(
          reverseDurationInMilliseconds: 0,
          durationInMilliseconds: 0,
        );
}
