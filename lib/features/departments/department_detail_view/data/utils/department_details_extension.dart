import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";

import "../../../../../config/env.dart";
import "../../../../../theme/hex_color.dart";
import "../../../../../utils/colors_sort.dart";
import "../models/department_details.dart";
import "department_detail_config.dart";

extension DetailedDepartmentsX on DepartmentDetails {
  LinearGradient get gradient =>
      LinearGradient(colors: [HexColor(gradientStart), HexColor(gradientStop)]..sortByLightness());

  String get imageUrl => "${Env.mainRestApiUrl.substring(0, Env.mainRestApiUrl.length - 7)}/uploads/$logoKey.png";

  String get address3lines {
    final match = RegExp(DepartmentDetailConfig.separateAddressPattern).firstMatch(addressLine1);
    return match != null ? "${match.group(1)}\n${match.group(2)}\n$addressLine2" : "$addressLine1\n$addressLine2";
  }
}

extension CycleStudiesFormatterX on FieldOfStudy {
  bool get isLongCycleStudies {
    return semesterCount == DepartmentDetailConfig.longCycleStudiesSemesterCount;
  }
}

extension WhereTypesX on IList<FieldOfStudy> {
  Iterable<FieldOfStudy> get whereFirstDegree {
    return where((item) => !item.is2ndDegree && !item.isLongCycleStudies);
  }

  Iterable<FieldOfStudy> get whereSecondDegree {
    return where((item) => item.is2ndDegree && !item.isLongCycleStudies);
  }

  Iterable<FieldOfStudy> get whereLongCycle {
    return where((item) => item.isLongCycleStudies);
  }
}
