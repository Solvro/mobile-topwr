import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "../data/models/field_of_study.dart";

extension _FixNullGettersX on FieldOfStudy {
  bool get is2ndDegreeF => is2ndDegree;
  // bool get isLongCycleStudiesF => isLongCycleStudies ?? false;
  bool get isLongCycleStudiesF => false;
}

extension WhereTypesX on IList<FieldOfStudy> {
  Iterable<FieldOfStudy> get whereFirstDegree {
    return where((item) => !item.is2ndDegreeF && !item.isLongCycleStudiesF);
  }

  Iterable<FieldOfStudy> get whereSecondDegree {
    return where((item) => item.is2ndDegreeF && !item.isLongCycleStudiesF);
  }

  Iterable<FieldOfStudy> get whereLongCycle {
    return where((item) => item.isLongCycleStudiesF);
  }
}
