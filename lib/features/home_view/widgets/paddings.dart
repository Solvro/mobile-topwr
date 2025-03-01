import "package:flutter/material.dart";

import "../../../config/ui_config.dart";

class SmallHorizontalPadding extends Padding {
  const SmallHorizontalPadding({super.key, super.child})
    : super(padding: const EdgeInsets.only(left: HomeViewConfig.paddingSmall, right: HomeViewConfig.paddingSmall));
}

class MediumLeftPadding extends Padding {
  const MediumLeftPadding({super.key, super.child})
    : super(padding: const EdgeInsets.only(left: HomeViewConfig.paddingMedium));
}

class MediumHorizontalPadding extends Padding {
  const MediumHorizontalPadding({super.key, super.child})
    : super(padding: const EdgeInsets.symmetric(horizontal: HomeViewConfig.paddingMedium));
}

class MediumBottomPadding extends Padding {
  const MediumBottomPadding({super.key, super.child})
    : super(padding: const EdgeInsets.only(bottom: HomeViewConfig.paddingMedium));
}
