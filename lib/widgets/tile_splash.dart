import "package:flutter/material.dart";

class TileSplash extends StatelessWidget {
  const TileSplash({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          color: Colors.transparent,
        ),
      ),
    );
  }
}
