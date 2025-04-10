import "package:flutter/widgets.dart";

import "../../../../../config/env.dart";
import "../../../../../theme/hex_color.dart";
import "../../../../../utils/colors_sort.dart";
import "../models/detailed_department.dart";

extension DepartmentsX on DetailedDepartment {
  LinearGradient get gradient =>
      LinearGradient(colors: [HexColor(gradientStart), HexColor(gradientStop)]..sortByLightness());

  String get imageUrl => "${Env.mainRestApiUrl.substring(0, Env.mainRestApiUrl.length - 7)}/uploads/$logoKey.png";
}
