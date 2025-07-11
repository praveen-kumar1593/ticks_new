import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class SharePrefCache {
  static const String _boxName = 'attendance_cache';
  final GetStorage _box = GetStorage(_boxName);

  Future<void> saveMap(String key, Map<String, dynamic> value) async {
    await _box.write(key, jsonEncode(value));
  }

  Map<String, dynamic>? getMap(String key) {
    final data = _box.read(key);
    if (data != null) {
      return jsonDecode(data) as Map<String, dynamic>;
    }
    return null;
  }

  Future<void> remove(String key) async {
    await _box.remove(key);
  }

  Future<void> clear() async {
    await _box.erase();
  }
}

class ShareprefConstant {
  static const String appTheme = 'app_theme';
  static const String userData = 'user_data';
  static const String loginCredentials = 'login_credentials';
} 