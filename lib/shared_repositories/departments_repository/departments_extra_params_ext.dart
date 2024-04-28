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

extension _GetDeptCode on Department? {
  static const _fallbackCode = 0;

  int extractIntFromStrCode() {
    if (this != null && this!.code.length >= 2) {
      return int.tryParse(this!.code.substring(1)) ?? _fallbackCode;
    }
    return _fallbackCode;
  }
}

extension SortDepartmentsByCode on List<Department?> {
  void sortByCodeOrder() {
    sort(
      (a, b) => a.extractIntFromStrCode().compareTo(
            b.extractIntFromStrCode(),
          ),
    );
  }
}
