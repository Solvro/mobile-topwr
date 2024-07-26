import "package:flutter/material.dart";

class PreviewTextPrototype extends Container {
  PreviewTextPrototype({
    super.key,
    super.width,
    super.height = 20,
  }) : super(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
        );
}
