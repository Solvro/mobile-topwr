import "dart:async";

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
    final hideTimer = useRef<Timer?>(null);

    void hideOverlay() {
      hideTimer.value?.cancel();
      hideTimer.value = null;
      final entry = overlayEntry.value;
      overlayEntry.value = null;
      if (entry != null && entry.mounted) {
        entry.remove();
      }
    }

    useEffect(() => hideOverlay, const []);

    final showTooltip = useCallback((TapDownDetails details) {
      hideOverlay();
      if (!context.mounted) return;
      final entry = _createOverlayEntry(context, details.globalPosition);
      Overlay.of(context).insert(entry);
      overlayEntry.value = entry;
      hideTimer.value = Timer(const Duration(seconds: 2), hideOverlay);
    }, [context]);

    final removeTooltip = useCallback(hideOverlay, const []);

    return GestureDetector(onTapDown: showTooltip, onTapCancel: removeTooltip, child: child);
  }

  OverlayEntry _createOverlayEntry(BuildContext context, Offset globalPosition) {
    return OverlayEntry(
      builder: (context) => CustomDateTooltip(position: globalPosition, message: message),
    );
  }
}

class CustomDateTooltip extends StatelessWidget {
  const CustomDateTooltip({super.key, required this.position, required this.message});
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
          decoration: BoxDecoration(color: context.colorScheme.onTertiary, borderRadius: BorderRadius.circular(8)),
          child: Text(message, style: context.textTheme.bodyLarge?.copyWith(color: context.colorScheme.surface)),
        ),
      ),
    );
  }
}
