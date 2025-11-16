import "package:riverpod_annotation/riverpod_annotation.dart";

part "radio_luz_global_button_position.g.dart";

typedef RadioLuzGlobalCurrentButtonPosState = ({double topEdge, double rightEdge});

@Riverpod(keepAlive: true)
class RadioLuzGlobalCurrentButtonPos extends _$RadioLuzGlobalCurrentButtonPos {
  @override
  RadioLuzGlobalCurrentButtonPosState build() => (topEdge: 0, rightEdge: 0);

  void setPosition({required double topEdge, required double rightEdge}) =>
      state = (topEdge: topEdge, rightEdge: rightEdge);
}

@Riverpod(keepAlive: true)
class RadioLuzGlobalLastButtonBottom extends _$RadioLuzGlobalLastButtonBottom {
  @override
  double build() => 0;

  void setBottom(double newBottom) => state = newBottom;
}
