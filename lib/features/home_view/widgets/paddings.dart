import 'package:flutter/material.dart';

import '../../../config.dart';

class SmallLeftPadding extends Padding {
  const SmallLeftPadding({super.key, super.child})
      : super(padding: const EdgeInsets.only(left: HomeScreenConfig.paddingSmall));
}

class MediumLeftPadding extends Padding {
  const MediumLeftPadding({super.key, super.child})
      : super(padding: const EdgeInsets.only(left: HomeScreenConfig.paddingMedium));
}