import "package:riverpod_annotation/riverpod_annotation.dart";

part "is_bottom_sheet_open.g.dart";

@Riverpod(keepAlive: true)
class IsBottomSheetOpen extends _$IsBottomSheetOpen {
  @override
  bool build() => false;

  void setState({required bool newState}) => state = newState;
}
