
import "package:flutter/material.dart";
import "../../../config/ui_config.dart";
import "../../../theme/hex_color.dart";
import "../../../utils/colors_sort.dart";
import "../repositories/department_details_repository.dart";

extension DepartmentsExtraParamsExt on DepartmentDetailsDetails {
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
