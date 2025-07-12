import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "newsfeed_models.freezed.dart";
part "newsfeed_models.g.dart";

@freezed
abstract class NewsfeedResponse with _$NewsfeedResponse {
  const factory NewsfeedResponse({required DateTime updateTime, required IList<Article> articles}) = _NewsfeedResponse;

  const NewsfeedResponse._();

  factory NewsfeedResponse.fromJson(Map<String, dynamic> json) => _$NewsfeedResponseFromJson(json);
}

@freezed
abstract class Article with _$Article {
  const factory Article({
    required String imageLink,
    required String title,
    required String url,
    required String date,
    required List<String> categories,
    required String previewText,
  }) = _Article;

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);
}
