import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../../../theme/app_theme.dart";

class TooltipOnTap extends HookWidget {
  final Widget child;
  final String message;

  const TooltipOnTap({required this.child, required this.message});

  @override
  Widget build(BuildContext context) {
    final overlayEntry = useRef<OverlayEntry?>(null);
    useEffect(
      () {
        return () {
          if (overlayEntry.value != null) {
            overlayEntry.value?.remove();
          }
        };
      },
      [],
    );
    final showTooltip = useCallback(
      (TapDownDetails details) {
        overlayEntry.value?.remove();
        final entry = _createOverlayEntry(context, details.globalPosition);
        Overlay.of(context).insert(entry);
        overlayEntry.value = entry;
        Future.delayed(const Duration(seconds: 2), () {
          overlayEntry.value?.remove();
          overlayEntry.value = null;
        });
      },
      [],
    );
    final removeTooltip = useCallback(
      () {
        overlayEntry.value?.remove();
        overlayEntry.value = null;
      },
      [],
    );
    return GestureDetector(
      onTapDown: showTooltip,
      onTapCancel: removeTooltip,
      child: child,
    );
  }

  OverlayEntry _createOverlayEntry(
    BuildContext context,
    Offset globalPosition,
  ) {
    return OverlayEntry(
      builder: (context) => CustomDateTooltip(
        position: globalPosition,
        message: message,
      ),
    );
  }
}

class CustomDateTooltip extends StatelessWidget {
  const CustomDateTooltip({
    super.key,
    required this.position,
    required this.message,
  });
  final Offset position;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx - 150,
      top: position.dy + 20,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: context.colorTheme.blackMirage,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            message,
            style: context.textTheme.bodyWhite,
          ),
        ),
      ),
    );
  }
}
