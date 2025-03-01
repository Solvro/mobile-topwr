class Timestamp extends DateTime {
  Timestamp.nil() : super(0);

  Timestamp.from(DateTime? ts) : super.fromMillisecondsSinceEpoch(ts?.millisecondsSinceEpoch ?? 0);

  Timestamp.tryParse(String? formattedString) : this.from(DateTime.tryParse(formattedString ?? ""));

  Timestamp.now() : super.now();

  String serializeUTC() {
    return toUtc().toIso8601String();
  }
}
