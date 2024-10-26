import "package:shared_preferences/shared_preferences.dart";
import "timestamp.dart";

extension SharedPreferencesX on SharedPreferences {
  Timestamp getTimestamp(String key) {
    final String? timestampString = getString(key);
    return Timestamp.tryParse(timestampString);
  }

  Future<void> saveTimestamp(String key, Timestamp timestamp) {
    return setString(key, timestamp.serializeUTC());
  }
}
