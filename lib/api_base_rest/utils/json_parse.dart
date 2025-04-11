extension JsonParseX on Map<String, dynamic> {
  Map<String, dynamic> parseJson() {
    return (containsKey("data") && this["data"] is Map<String, dynamic>) ? this["data"] as Map<String, dynamic> : this;
  }

  List<dynamic> parseJsonToList() {
    try {
      return List.from(this["data"] as List<dynamic>);
    } catch (e) {
      throw FormatException('Error parsing json["data"] to List<String>: $e');
    }
  }
}
