import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:latlong2/latlong.dart";

import "../../../../api_base_rest/shared_models/image_data.dart";
import "../../../../l10n/app_localizations.dart";
import "../../../map_view/controllers/controllers_set.dart";
import "building.dart";

part "pink_box.freezed.dart";
part "pink_box.g.dart";

@freezed
abstract class PinkBoxDataResponse with _$PinkBoxDataResponse {
  const factory PinkBoxDataResponse({required IList<PinkBox> data}) = _PinkBoxDataResponse;
  const PinkBoxDataResponse._();
  factory PinkBoxDataResponse.fromJson(Map<String, dynamic> json) => _$PinkBoxDataResponseFromJson(json);
}

@freezed
abstract class PinkBox with _$PinkBox implements GoogleNavigable {
  @Implements<GoogleNavigable>()
  const factory PinkBox({
    @JsonKey(name: "id") required int rawId,
    required String? roomOrNearby,
    required double latitude,
    required double longitude,
    ImageData? photo,
    Building? building,
  }) = _PinkBox;

  const PinkBox._();

  factory PinkBox.fromJson(Map<String, dynamic> json) => _$PinkBoxFromJson(json);

  @override
  String get id => rawId.toString();

  @override
  LatLng get location => LatLng(latitude, longitude);

  String title(AppLocalizations l10n) => "${l10n.pink_box_single} — ${building?.name}";
}
