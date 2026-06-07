import "dart:math" as math;

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";

// Based on the Flutter issue workaround discussed here:
// https://github.com/flutter/flutter/issues/44557#issuecomment-664416718
//
// Original implementation:
// https://gist.github.com/tomaszpolanski/cf0edb7961d2304c2f293da9971cd4c9

class SliverStickyHeader extends RenderObjectWidget {
  final Widget child;

  const SliverStickyHeader({required this.child});

  @override
  RenderSliverStickyHeader createRenderObject(BuildContext context) {
    return RenderSliverStickyHeader();
  }

  @override
  SliverStickyHeaderElement createElement() => SliverStickyHeaderElement(this);
}

class SliverStickyHeaderElement extends RenderObjectElement {
  SliverStickyHeaderElement(super.widget);

  @override
  RenderSliverStickyHeader get renderObject => super.renderObject as RenderSliverStickyHeader;

  @override
  void mount(Element? parent, Object? newSlot) {
    super.mount(parent, newSlot);
    renderObject._element = this;
  }

  @override
  void unmount() {
    renderObject._element = null;
    super.unmount();
  }

  @override
  void update(SliverStickyHeader newWidget) {
    final oldWidget = widget as SliverStickyHeader;
    super.update(newWidget);
    final newChild = newWidget.child;
    final oldChild = oldWidget.child;
    if (newChild != oldChild) {
      renderObject.triggerRebuild();
    }
  }

  @override
  void performRebuild() {
    super.performRebuild();
    renderObject.triggerRebuild();
  }

  Element? child;

  void _build() {
    owner!.buildScope(this, () {
      final headerWidget = widget as SliverStickyHeader;
      child = updateChild(child, headerWidget.child, null);
    });
  }

  @override
  void forgetChild(Element child) {
    assert(child == this.child, "forgetChild");
    this.child = null;
    super.forgetChild(child);
  }

  @override
  void insertRenderObjectChild(covariant RenderBox child, Object? slot) {
    assert(renderObject.debugValidateChild(child), "insertRenderObjectChild");
    renderObject.child = child;
  }

  @override
  void moveRenderObjectChild(covariant RenderObject child, Object? oldSlot, Object? newSlot) {
    assert(false, "moveRenderObjectChild");
  }

  @override
  void removeRenderObjectChild(covariant RenderObject child, Object? slot) {
    renderObject.child = null;
  }

  @override
  void visitChildren(ElementVisitor visitor) {
    if (child != null) {
      visitor(child!);
    }
  }
}

// --------------------- renderer --------------------------- //

Rect? _trim(
  Rect? original, {
  double top = -double.infinity,
  double right = double.infinity,
  double bottom = double.infinity,
  double left = -double.infinity,
}) => original?.intersect(Rect.fromLTRB(left, top, right, bottom));

class RenderSliverStickyHeader extends RenderSliver with RenderObjectWithChildMixin<RenderBox>, RenderSliverHelpers {
  double? _lastActualScrollOffset;
  late double? _effectiveScrollOffset;

  double? _childPosition;

  SliverStickyHeaderElement? _element;

  RenderSliverStickyHeader({RenderBox? child}) {
    this.child = child;
  }

  @protected
  double get childExtent {
    if (child == null) {
      return 0;
    }
    assert(child!.hasSize, "childExtent");
    switch (constraints.axis) {
      case Axis.vertical:
        return child!.size.height;
      case Axis.horizontal:
        return child!.size.width;
    }
  }

  var _needsUpdateChild = true;

  @override
  void markNeedsLayout() {
    _needsUpdateChild = true;
    super.markNeedsLayout();
  }

  @protected
  void layoutChild(double scrollOffset, double maxExtent, {bool overlapsContent = false}) {
    if (_needsUpdateChild) {
      invokeLayoutCallback<SliverConstraints>((SliverConstraints constraints) {
        assert(constraints == this.constraints, "invokeLayoutCallback");
        updateChild();
      });
      _needsUpdateChild = false;
    }
    child?.layout(constraints.asBoxConstraints(), parentUsesSize: true);
  }

  @override
  bool hitTestChildren(
    SliverHitTestResult result, {
    required double mainAxisPosition,
    required double crossAxisPosition,
  }) {
    assert(geometry!.hitTestExtent > 0.0, "hitTestChildren");
    if (child != null) {
      return hitTestBoxChild(
        BoxHitTestResult.wrap(result),
        child!,
        mainAxisPosition: mainAxisPosition,
        crossAxisPosition: crossAxisPosition,
      );
    }
    return false;
  }

  @override
  void applyPaintTransform(RenderObject child, Matrix4 transform) {
    assert(child == this.child, "applyPaintTransform");
    applyPaintTransformForBoxChild(child as RenderBox, transform);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    var paintedOffset = offset;
    if (child != null && geometry!.visible) {
      switch (applyGrowthDirectionToAxisDirection(constraints.axisDirection, constraints.growthDirection)) {
        case AxisDirection.up:
          paintedOffset += Offset(0, geometry!.paintExtent - childMainAxisPosition(child!) - childExtent);
        case AxisDirection.down:
          paintedOffset += Offset(0, childMainAxisPosition(child!));
        case AxisDirection.left:
          paintedOffset += Offset(geometry!.paintExtent - childMainAxisPosition(child!) - childExtent, 0);
        case AxisDirection.right:
          paintedOffset += Offset(childMainAxisPosition(child!), 0);
      }
      context.paintChild(child!, paintedOffset);
    }
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);
    config.addTagForChildren(RenderViewport.excludeFromScrolling);
  }

  // pinned floating

  @protected
  double updateGeometry() {
    final double minExtent = childExtent;
    final double minAllowedExtent = constraints.remainingPaintExtent > minExtent
        ? minExtent
        : constraints.remainingPaintExtent;
    final double maxExtent = childExtent;
    final double paintExtent = maxExtent - _effectiveScrollOffset!;
    final double clampedPaintExtent = clampDouble(paintExtent, minAllowedExtent, constraints.remainingPaintExtent);
    final double layoutExtent = maxExtent - constraints.scrollOffset;
    geometry = SliverGeometry(
      scrollExtent: maxExtent,
      paintOrigin: math.min(constraints.overlap, 0),
      paintExtent: clampedPaintExtent,
      layoutExtent: clampDouble(layoutExtent, 0, clampedPaintExtent),
      maxPaintExtent: maxExtent,
      maxScrollObstructionExtent: minExtent,
      hasVisualOverflow: true,
    );
    return 0;
  }

  @override
  void performLayout() {
    final SliverConstraints constraints = this.constraints;
    final double maxExtent = childExtent;
    if (_lastActualScrollOffset != null &&
        ((constraints.scrollOffset < _lastActualScrollOffset!) || (_effectiveScrollOffset! < maxExtent))) {
      double delta = _lastActualScrollOffset! - constraints.scrollOffset;

      if (constraints.userScrollDirection == ScrollDirection.forward) {
        if (_effectiveScrollOffset! > maxExtent) {
          _effectiveScrollOffset = maxExtent;
        }
      } else {
        if (delta > 0.0) {
          delta = 0.0;
        }
      }
      _effectiveScrollOffset = clampDouble(_effectiveScrollOffset! - delta, 0, constraints.scrollOffset);
    } else {
      _effectiveScrollOffset = constraints.scrollOffset;
    }
    final bool overlapsContent = _effectiveScrollOffset! < constraints.scrollOffset;

    layoutChild(_effectiveScrollOffset!, maxExtent, overlapsContent: overlapsContent);
    _childPosition = updateGeometry();
    _lastActualScrollOffset = constraints.scrollOffset;
  }

  @override
  void showOnScreen({
    RenderObject? descendant,
    Rect? rect,
    Duration duration = Duration.zero,
    Curve curve = Curves.ease,
  }) {
    assert(child != null || descendant == null, "showOnScreen");

    final Rect? childBounds = descendant != null
        ? MatrixUtils.transformRect(descendant.getTransformTo(child), rect ?? descendant.paintBounds)
        : rect;
    Rect? targetRect;
    switch (applyGrowthDirectionToAxisDirection(constraints.axisDirection, constraints.growthDirection)) {
      case AxisDirection.up:
        targetRect = _trim(childBounds, bottom: childExtent);
      case AxisDirection.right:
        targetRect = _trim(childBounds, left: 0);
      case AxisDirection.down:
        targetRect = _trim(childBounds, top: 0);
      case AxisDirection.left:
        targetRect = _trim(childBounds, right: childExtent);
    }

    super.showOnScreen(
      descendant: descendant == null ? this : child,
      rect: targetRect,
      duration: duration,
      curve: curve,
    );
  }

  @override
  double childMainAxisPosition(RenderBox child) {
    assert(child == this.child, "childMainAxisPosition");
    return _childPosition ?? 0.0;
  }

  void updateChild() {
    assert(_element != null, "updateChild");
    _element!._build();
  }

  @protected
  void triggerRebuild() {
    markNeedsLayout();
  }
}
