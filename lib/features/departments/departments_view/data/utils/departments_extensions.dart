import "package:flutter/material.dart";

import "../../../../../config/env.dart";
import "../../../../../theme/hex_color.dart";
import "../../../../../utils/colors_sort.dart";
import "../models/department.dart";

extension DepartmentsX on Department {
  LinearGradient get gradient =>
      LinearGradient(colors: [HexColor(gradientStart), HexColor(gradientStop)]..sortByLightness());

  String get imageUrl => "${Env.mainRestApiUrl.substring(0, Env.mainRestApiUrl.length - 7)}/uploads/$logoKey.png";
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
    sort((a, b) => a.extractIntFromStrCode().compareTo(b.extractIntFromStrCode()));
  }
}
