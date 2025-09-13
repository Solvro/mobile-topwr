import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:latlong2/latlong.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

import "../../../../api_base_rest/shared_models/image_data.dart";
import "../../../map_view/controllers/controllers_set.dart";

part "building.freezed.dart";
part "building.g.dart";
part "building.translatable.g.dart";

@JsonEnum(fieldRename: FieldRename.snake)
enum ExternalDigitalGuideMode { webUrl, digitalGuideBuilding, otherDigitalGuidePlace }

@freezed
@Translatable(makeFieldsTranslatableByDefault: false)
abstract class BuildingDataResponse
    with _$BuildingDataResponse, _$BuildingDataResponseTranslatable
    implements TranslatableInterface {
  const factory BuildingDataResponse({required IList<Building> data}) = _BuildingDataResponse;

  const BuildingDataResponse._();
  factory BuildingDataResponse.fromJson(Map<String, dynamic> json) => _$BuildingDataResponseFromJson(json);
}

@freezed
abstract class Building with _$Building implements GoogleNavigable {
  @Implements<GoogleNavigable>()
  const factory Building({
    @JsonKey(name: "id") required int rawId,
    @JsonKey(name: "identifier") required String name,
    @translatableField @JsonKey(name: "specialName") required String? naturalName,
    required String addressLine1,
    required String addressLine2,
    required double latitude,
    required double longitude,
    required ExternalDigitalGuideMode? externalDigitalGuideMode,
    required String? externalDigitalGuideIdOrUrl,
    required ImageData? cover,
  }) = _Building;

  const Building._();

  factory Building.fromJson(Map<String, dynamic> json) => _$BuildingFromJson(json);

  @override
  String get id => rawId.toString();

  @override
  LatLng get location => LatLng(latitude, longitude);

  String get address => "$addressLine1\n$addressLine2".replaceFirst(",", "\n").replaceAll("\n ", "\n");
}
