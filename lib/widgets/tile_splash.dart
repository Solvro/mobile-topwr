import "package:flutter/material.dart";

class TileSplash extends StatelessWidget {
  const TileSplash({super.key, this.onTap, this.child});

  final VoidCallback? onTap;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: ColoredBox(color: Colors.transparent, child: child ?? const SizedBox.expand()),
      ),
    );
  }
}

// If tile splash doesn't work read this article
// https://therdm.medium.com/ripple-effect-not-working-on-inkwell-try-the-ink-widget-44b6a1964de0
