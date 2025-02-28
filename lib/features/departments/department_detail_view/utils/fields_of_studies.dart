import "package:fast_immutable_collections/fast_immutable_collections.dart";

import "../widgets/fields_of_study_section.dart";

extension _FixNullGettersX on FieldOfStudy {
  bool get is2ndDegreeF => is2ndDegree ?? false;
  bool get isLongCycleStudiesF => isLongCycleStudies ?? false;
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
