import "package:flutter/widgets.dart";

import "../../../../../config/env.dart";
import "../../../../../theme/hex_color.dart";
import "../../../../../utils/colors_sort.dart";
import "../models/detailed_department.dart";

extension DetailedDepartmentsX on DetailedDepartment {
  LinearGradient get gradient =>
      LinearGradient(colors: [HexColor(gradientStart), HexColor(gradientStop)]..sortByLightness());

  String get imageUrl => "${Env.mainRestApiUrl.substring(0, Env.mainRestApiUrl.length - 7)}/uploads/$logoKey.png";

  String get address3lines {
    final match = RegExp(r"^(.*)\s((ul\.|wyb\.|pl\.).*)").firstMatch(addressLine1);
    return match != null ? "${match.group(1)}\n${match.group(2)}\n$addressLine2" : "$addressLine1\n$addressLine2";
  }
}
