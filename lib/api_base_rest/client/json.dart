import "package:fast_immutable_collections/fast_immutable_collections.dart";

// sealed class for JSON types

sealed class JSON<T> {
  const JSON();
}

class ObjectJSON<T> extends JSON<T> {
  final T value;
  const ObjectJSON(this.value);
}

class ListJSON<T> extends JSON<T> {
  final IList<T> value;
  const ListJSON(this.value);
}

// casting extensions

extension JsonCasterX<T> on JSON<T> {
  IList<T> get castAsList =>
      this is ListJSON<T>
          ? (this as ListJSON<T>).value
          : throw ArgumentError("Wrong JSON casting type: $this. Expected ListJSON<T>");

  T get castAsObject =>
      this is ObjectJSON<T>
          ? (this as ObjectJSON<T>).value
          : throw ArgumentError("Wrong JSON casting type: $this. Expected ObjectJSON<T>");
}

extension JsonCasterOnFutureX<T> on Future<JSON<T>> {
  Future<T> get castAsObject async {
    final json = await this;
    return json.castAsObject;
  }

  Future<IList<T>> get castAsList async {
    final json = await this;
    return json.castAsList;
  }
}

// parsing function

JSON<T> parseJSON<T>(dynamic data, T Function(Map<String, dynamic> json) jsonParser) {
  if (data is List<dynamic>) {
    return ListJSON(data.cast<Map<String, dynamic>>().map(jsonParser).toIList());
  }

  if (data is Map<String, dynamic>) {
    return ObjectJSON(jsonParser(data));
  }

  throw ArgumentError("Invalid JSON type: $data");
}
