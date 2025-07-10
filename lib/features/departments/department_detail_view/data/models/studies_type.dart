import "package:freezed_annotation/freezed_annotation.dart";

part "studies_type.g.dart";

@JsonEnum(fieldRename: FieldRename.snake, alwaysCreate: true)
enum StudiesType {
  @JsonValue("1DEGREE")
  firstDegree,

  @JsonValue("2DEGREE")
  secondDegree,

  @JsonValue("LONG_CYCLE")
  longCycle,
}

extension StudiesTypeX on StudiesType {
  bool get isFirstDegree => this == StudiesType.firstDegree;
  bool get isSecondDegree => this == StudiesType.secondDegree;
  bool get isLongCycle => this == StudiesType.longCycle;
}
