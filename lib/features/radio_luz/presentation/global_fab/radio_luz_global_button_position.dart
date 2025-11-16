import "package:riverpod_annotation/riverpod_annotation.dart";

part "radio_luz_global_button_position.g.dart";

typedef RadioLuzGlobalButtonPosState = ({double topEdge, double rightEdge});

@riverpod
class RadioLuzGlobalButtonPos extends _$RadioLuzGlobalButtonPos {
  @override
  RadioLuzGlobalButtonPosState build() => (topEdge: 0, rightEdge: 0);

  void setPosition({required double topEdge, required double rightEdge}) =>
      state = (topEdge: topEdge, rightEdge: rightEdge);
}
