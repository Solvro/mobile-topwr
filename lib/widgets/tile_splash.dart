import "package:flutter/material.dart";

class TileSplash extends StatelessWidget {
  const TileSplash({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(onTap: onTap, child: Container(color: Colors.transparent)),
    );
  }
}

// If tile splash doesn't work read this article
// https://therdm.medium.com/ripple-effect-not-working-on-inkwell-try-the-ink-widget-44b6a1964de0
