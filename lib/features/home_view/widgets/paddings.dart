import 'package:flutter/material.dart';

import '../../../config/ui_config.dart';

class SmallHorizontalPadding extends Padding {
  const SmallHorizontalPadding({super.key, super.child})
      : super(
            padding: const EdgeInsets.only(
                left: HomeScreenConfig.paddingSmall,
                right: HomeScreenConfig.paddingSmall));
}

class MediumLeftPadding extends Padding {
  const MediumLeftPadding({super.key, super.child})
      : super(
            padding:
                const EdgeInsets.only(left: HomeScreenConfig.paddingMedium));
}
