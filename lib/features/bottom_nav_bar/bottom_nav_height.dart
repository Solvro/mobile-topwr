import "package:riverpod_annotation/riverpod_annotation.dart";

part "bottom_nav_height.g.dart";

@riverpod
class BottomNavBarHeight extends _$BottomNavBarHeight {
  @override
  double build() => 0;

  void setHeight(double newHeight) => state = newHeight;
}
