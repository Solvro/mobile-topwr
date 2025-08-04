part of "scrollable_list_tab_scroller.dart";

class TabBarProps {
  final bool isScrollable;

  final EdgeInsetsGeometry? padding;

  final Color? indicatorColor;

  final bool automaticIndicatorColorAdjustment;

  final double indicatorWeight;

  final EdgeInsetsGeometry indicatorPadding;

  final Decoration? indicator;

  final TabBarIndicatorSize? indicatorSize;

  final Color? dividerColor;

  final Color? labelColor;

  final TextStyle? labelStyle;

  final EdgeInsetsGeometry? labelPadding;

  final Color? unselectedLabelColor;

  final TextStyle? unselectedLabelStyle;

  final DragStartBehavior dragStartBehavior;

  final WidgetStateProperty<Color?>? overlayColor;

  final MouseCursor? mouseCursor;

  final bool? enableFeedback;

  final ScrollPhysics? physics;

  final InteractiveInkFeatureFactory? splashFactory;

  final BorderRadius? splashBorderRadius;

  final TabAlignment? tabAlignment;

  const TabBarProps({
    this.isScrollable = true,
    this.padding,
    this.indicatorColor,
    this.automaticIndicatorColorAdjustment = false,
    this.indicatorWeight = 0,
    this.indicatorPadding = EdgeInsets.zero,
    this.indicator = const BoxDecoration(),
    this.indicatorSize,
    this.dividerColor,
    this.labelColor = const _DefaultTextStyleColor(),
    this.labelStyle,
    this.labelPadding = EdgeInsets.zero,
    this.unselectedLabelColor,
    this.unselectedLabelStyle,
    this.dragStartBehavior = DragStartBehavior.start,
    this.overlayColor = const WidgetStatePropertyAll(Colors.transparent),
    this.mouseCursor,
    this.enableFeedback,
    this.physics,
    this.splashFactory,
    this.splashBorderRadius,
    this.tabAlignment = TabAlignment.start,
  });
}

class _DefaultTextStyleColor extends Color {
  const _DefaultTextStyleColor()
    : // This color is ignored and replaced in runtime
      super(0);
}
