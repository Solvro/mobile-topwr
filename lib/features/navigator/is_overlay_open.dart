import "package:riverpod_annotation/riverpod_annotation.dart";

part "is_overlay_open.g.dart";

@riverpod
class IsOverlayOpen extends _$IsOverlayOpen {
  @override
  bool build() => false;

  void setState({required bool newState}) => state = newState;
}
