import "package:flutter/material.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/hex_color.dart";
import "../../../../utils/colors_sort.dart";
import "departments_repository.dart";

extension DepartmentsX on Department {
  LinearGradient get gradient => LinearGradient(
        colors: [
          HexColor(
            gradient_start ?? DepartmentsConfig.defaultColorFirst,
          ),
          HexColor(
            gradient_end ?? DepartmentsConfig.defaultColorSecond,
          ),
        ]..sortByLightness(),
      );
}

extension _GetDepartmentsCodeX on Department? {
  static const _fallbackCode = 0;

  int extractIntFromStrCode() {
    if (this != null && this!.code.length >= 2) {
      return int.tryParse(this!.code.substring(1)) ?? _fallbackCode;
    }
    return _fallbackCode;
  }
}

extension SortByCodeX on List<Department?> {
  void sortByCodeOrder() {
    sort(
      (a, b) => a.extractIntFromStrCode().compareTo(
            b.extractIntFromStrCode(),
          ),
    );
  }
}
