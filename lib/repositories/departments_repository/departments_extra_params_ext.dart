import 'package:flutter/material.dart';

import '../../config.dart';
import '../../theme/hex_color.dart';
import '../../utils/colors_sort.dart';
import 'departments_repository.dart';

extension DepartmentsExtraParamsExt on Department {
  LinearGradient get gradient => LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          HexColor(
            color?.gradientFirst ?? DepartmentsConfig.defaultColorFirst,
          ),
          HexColor(
            color?.gradientSecond ?? DepartmentsConfig.defaultColorSecond,
          )
        ]..sortByLightness(),
      );
}
