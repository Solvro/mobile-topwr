import "package:flutter/material.dart";

import "../../../config/ui_config.dart";

class PreviewTextPrototype extends Container {
  PreviewTextPrototype({super.key, super.width, super.height = 20})
    : super(
        decoration: BoxDecoration(
          color: ShimmerLoadingConfig.placeholderColor,
          borderRadius: BorderRadius.circular(16),
        ),
      );
}
