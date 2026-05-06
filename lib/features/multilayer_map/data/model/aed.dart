import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:latlong2/latlong.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

import "../../../../api_base_rest/shared_models/image_data.dart";
import "../../../branches/data/model/branch.dart";
import "../../../map_view/controllers/controllers_set.dart";
import "building.dart";

part "aed.freezed.dart";
part "aed.g.dart";
part "aed.translatable.g.dart";

@freezed
@Translatable(makeFieldsTranslatableByDefault: false)
abstract class AedDataResponse with _$AedDataResponse, _$AedDataResponseTranslatable {
  const factory AedDataResponse({@translatableField required IList<Aed> data}) = _AedDataResponse;
  const AedDataResponse._();
  factory AedDataResponse.fromJson(Map<String, dynamic> json) => _$AedDataResponseFromJson(json);
}

@freezed
abstract class Aed with _$Aed implements GoogleNavigable {
  @Implements<GoogleNavigable>()
  const factory Aed({
    @JsonKey(name: "id") required int rawId,
    required double latitude,
    required double longitude,
    required ImageData? photo,
    required String? addressLine1,
    required String? addressLine2,
    @translatableField required String? instructions,
    Building? building,
    required Branch branch,
  }) = _Aed;

  const Aed._();

  factory Aed.fromJson(Map<String, dynamic> json) => _$AedFromJson(json);

  @override
  String get id => rawId.toString();

  @override
  LatLng get location => LatLng(latitude, longitude);

  String get title => "AED — ${building?.name}";
}
