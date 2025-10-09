import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:latlong2/latlong.dart";

import "../../../../api_base_rest/shared_models/image_data.dart";
import "../../../branches/data/model/branch.dart";
import "../../../map_view/controllers/controllers_set.dart";
import "building.dart";

part "library.freezed.dart";
part "library.g.dart";

@freezed
abstract class LibraryDataResponse with _$LibraryDataResponse {
  const factory LibraryDataResponse({required IList<Library> data}) = _LibraryDataResponse;
  const LibraryDataResponse._();
  factory LibraryDataResponse.fromJson(Map<String, dynamic> json) => _$LibraryDataResponseFromJson(json);
}

@freezed
abstract class Library with _$Library implements GoogleNavigable {
  @Implements<GoogleNavigable>()
  const factory Library({
    @JsonKey(name: "id") required int rawId,
    required String title,
    required String? room,
    required double latitude,
    required double longitude,
    ImageData? photo,
    Building? building,
    required Branch branch,
  }) = _Library;

  const Library._();

  factory Library.fromJson(Map<String, dynamic> json) => _$LibraryFromJson(json);

  @override
  String get id => rawId.toString();

  @override
  LatLng get location => LatLng(latitude, longitude);
}
