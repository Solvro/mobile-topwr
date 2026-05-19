import "package:flutter/material.dart";

import "../../../../../theme/hex_color.dart";
import "../../../../../utils/colors_sort.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../branches/data/model/branch.dart";
import "../models/department.dart";

extension DepartmentsX on Department {
  LinearGradient get gradient =>
      LinearGradient(colors: [HexColor(gradientStart), HexColor(gradientStop)]..sortByLightness());

  String? displayName(BuildContext context) {
    if (branch == Branch.main) return name;
    return branch.localize(context.localize);
  }
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

extension SortByCodeX on List<Department> {
  void sortByCodeOrder() {
    sort((a, b) {
      final aStartsWithW = a.code.startsWith("W") && !a.code.startsWith("W0");
      final bStartsWithW = b.code.startsWith("W") && !b.code.startsWith("W0");

      if (aStartsWithW != bStartsWithW) return aStartsWithW ? -1 : 1;

      if (aStartsWithW) {
        return a.extractIntFromStrCode().compareTo(b.extractIntFromStrCode());
      }

      return a.code.toLowerCase().compareTo(b.code.toLowerCase());
    });
  }
}
