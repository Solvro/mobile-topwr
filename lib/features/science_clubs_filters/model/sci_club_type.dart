import "package:flutter/material.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../../../../utils/context_extensions.dart";

part "sci_club_type.g.dart";

@JsonEnum(fieldRename: FieldRename.snake, alwaysCreate: true)
enum ScienceClubType {
  scientificCirlce,
  culturalAgenda,
  studentOrganization,
  studentMedia;

  String? toJson() => _$ScienceClubTypeEnumMap[this];
}

extension GetDisplayNameX on BuildContext {
  String sciClubTypeDisplayName(ScienceClubType it) => switch (it) {
        ScienceClubType.scientificCirlce => localize.scientific_cirlces,
        ScienceClubType.culturalAgenda => localize.cultural_agendas,
        ScienceClubType.studentOrganization => localize.student_organizations,
        ScienceClubType.studentMedia => localize.student_medias,
      };
}
