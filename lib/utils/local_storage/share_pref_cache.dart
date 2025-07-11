import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharePrefCache {
  static final SharePrefCache _instance = SharePrefCache._internal();
  late SharedPreferences _prefs;

  // Private constructor
  SharePrefCache._internal();

  // Factory constructor to return the same instance
  factory SharePrefCache() {
    return _instance;
  }

  // Initialize SharedPreferences (Call this in main() before using)
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Save String
  Future<void> saveString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  String? getString(String key) => _prefs.getString(key);

  // Save Integer
  Future<void> saveInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  int? getInt(String key) => _prefs.getInt(key);

  // Save Boolean
  Future<void> saveBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  bool? getBool(String key) => _prefs.getBool(key);

  // Save Double
  Future<void> saveDouble(String key, double value) async {
    await _prefs.setDouble(key, value);
  }

  double? getDouble(String key) => _prefs.getDouble(key);

  // Save List of Strings
  Future<void> saveStringList(String key, List<String> value) async {
    await _prefs.setStringList(key, value);
  }

  List<String>? getStringList(String key) => _prefs.getStringList(key);

  // Save Map (as JSON)
  Future<void> saveMap(String key, Map<String, dynamic> value) async {
    await _prefs.setString(key, jsonEncode(value));
  }

  Map<String, dynamic>? getMap(String key) {
    String? jsonString = _prefs.getString(key);
    return jsonString != null ? jsonDecode(jsonString) : null;
  }

  // Remove a single key
  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  // Clear all stored data
  Future<void> clearAll({List<String>? excludedKeys}) async {
    Set<String> allKeys = _prefs.getKeys();
    Set<String> keysToKeep = excludedKeys?.toSet() ?? {};

    // // Debug prints
    // debugPrint("📝 All Keys: $allKeys");
    // debugPrint("🚫 Excluded Keys: $keysToKeep");

    for (String key in allKeys) {
      if (!keysToKeep.contains(key)) {
        // debugPrint("❌ Deleting: $key");
        await _prefs.remove(key);
      } else {
        // debugPrint("✅ Keeping: $key");
      }
    }
  }
}
