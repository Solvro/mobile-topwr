import "package:riverpod_annotation/riverpod_annotation.dart";

part "route_params_controller.g.dart";

@riverpod
class RouteParamsController extends _$RouteParamsController {
  @override
  String? build() => null;

  void onParamsChanged(String? newValue) {
    state = newValue;
    print("changing!!!! $state");
  }
}
