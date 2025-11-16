import "package:flutter/material.dart";
import "package:flutter/rendering.dart";

typedef OnSizeChange = void Function(Size size, double top, double right, double bottom, double left);

class PositionDetector extends SingleChildRenderObjectWidget {
  const PositionDetector({super.key, required this.onChange, required Widget child}) : super(child: child);

  final OnSizeChange onChange;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return MeasureRenderObject(onChange);
  }

  @override
  void updateRenderObject(BuildContext context, covariant MeasureRenderObject renderObject) {
    renderObject.onChange = onChange;
  }
}

class MeasureRenderObject extends RenderProxyBox {
  MeasureRenderObject(this.onChange);

  OnSizeChange onChange;
  Rect? _lastGlobalRect;

  @override
  void performLayout() {
    super.performLayout();

    final globalRect = _getRectGlobal();
    _lastGlobalRect = globalRect;
    _emitIfChanged(globalRect);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);

    final rect = _getRectGlobal();
    _emitIfChanged(rect);
  }

  Rect _getRectGlobal() => MatrixUtils.transformRect(getTransformTo(null), Offset.zero & size);

  Size _currentViewSize() {
    for (final renderView in RendererBinding.instance.renderViews) {
      try {
        getTransformTo(renderView);
        return renderView.size;
      } on Exception {
        continue;
      }
    }
    return RendererBinding.instance.renderViews.first.size;
  }

  void _emitIfChanged(Rect rect) {
    final last = _lastGlobalRect;

    final changed =
        last == null ||
        (rect.left - last.left).abs() > 0.5 ||
        (rect.top - last.top).abs() > 0.5 ||
        (rect.width - last.width).abs() > 0.5 ||
        (rect.height - last.height).abs() > 0.5;

    if (!changed) return;

    _lastGlobalRect = rect;

    final viewSize = _currentViewSize();
    final top = rect.top;
    final left = rect.left;
    final bottom = viewSize.height - rect.bottom;
    final right = viewSize.width - rect.right;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      onChange(rect.size, top, right, bottom, left);
    });
  }
}
