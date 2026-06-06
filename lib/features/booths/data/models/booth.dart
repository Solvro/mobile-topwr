import "package:flutter/material.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

import "../../../../l10n/app_localizations.dart";
import "../../../../theme/colors.dart";

part "booth.freezed.dart";
part "booth.g.dart";
part "booth.translatable.g.dart";

enum BoothStatus { available, occupied, offline }

@freezed
@Translatable(makeFieldsTranslatableByDefault: false)
abstract class Booth with _$Booth, _$BoothTranslatable {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Booth({
    @JsonKey(name: "booth_id") required String id,
    @translatableField @JsonKey(name: "booth_name") required String name,
    required String photoUrl,
    @Default("") String photoMiniatureUrl,
    @translatableField required String localization,
    required bool? isOccupied,
    required DateTime? reportedAt,
    required bool isOnline,
  }) = _Booth;

  const Booth._();

  factory Booth.fromJson(Map<String, dynamic> json) => _$BoothFromJson(json);

  String get displayPhotoUrl => photoMiniatureUrl.isNotEmpty ? photoMiniatureUrl : photoUrl;

  BoothStatus get status {
    if (!isOnline || isOccupied == null) return BoothStatus.offline;
    return isOccupied! ? BoothStatus.occupied : BoothStatus.available;
  }
}

extension BoothStatusX on BoothStatus {
  Color color(BuildContext context) => switch (this) {
    BoothStatus.available => ColorsConsts.trendUp,
    BoothStatus.occupied => ColorsConsts.trendDown,
    BoothStatus.offline => ColorsConsts.statusOffline,
  };

  String localizedName(AppLocalizations localize) => switch (this) {
    BoothStatus.available => localize.booth_status_available,
    BoothStatus.occupied => localize.booth_status_occupied,
    BoothStatus.offline => localize.booth_status_offline,
  };
}
