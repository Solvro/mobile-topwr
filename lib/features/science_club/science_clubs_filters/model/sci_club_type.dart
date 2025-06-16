import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../../../../../utils/context_extensions.dart";
import "../../../../utils/watch_locale.dart";

part "sci_club_type.g.dart";

@JsonEnum(fieldRename: FieldRename.snake, alwaysCreate: true)
enum ScienceClubType {
  scientificClub,
  cultureAgenda,
  studentOrganization,
  studentCouncil,
  studentMedium;

  String? toJson() => _$ScienceClubTypeEnumMap[this];
}

extension GetDisplayNameX on BuildContext {
  String sciClubTypeDisplayName(ScienceClubType it) => switch (it) {
    ScienceClubType.scientificClub => localize.scientific_cirlces,
    ScienceClubType.cultureAgenda => localize.cultural_agendas,
    ScienceClubType.studentOrganization => localize.student_organizations,
    ScienceClubType.studentMedium => localize.student_medias,
    ScienceClubType.studentCouncil => localize.student_councils,
  };
}

extension GetDisplayNameRefX on Ref {
  String sciClubTypeDisplayName(ScienceClubType it) => switch (it) {
    ScienceClubType.scientificClub => read(watchLocaleProvider).scientific_cirlces,
    ScienceClubType.cultureAgenda => read(watchLocaleProvider).cultural_agendas,
    ScienceClubType.studentOrganization => read(watchLocaleProvider).student_organizations,
    ScienceClubType.studentMedium => read(watchLocaleProvider).student_medias,
    ScienceClubType.studentCouncil => read(watchLocaleProvider).student_councils,
  };
}
