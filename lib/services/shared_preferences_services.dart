import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class SharedPrefrencesServices extends GetxService {
  late SharedPreferences _prefs;
  bool _initialized = false;

  @override
  void onInit() async {
    super.onInit();
    await init();
  }

  Future<void> init() async {
    if (!_initialized) {
      _prefs = await SharedPreferences.getInstance();
      _initialized = true;
    }
  }

  String? getData({required String key}) {
    return _prefs.getString(key);
  }
  
  Future<void> setData(String key, String value) async {
    if (!_initialized) await init();
    await _prefs.setString(key, value);
  }

  Future<int?> getInt(String key) async {
    if (!_initialized) await init();
    return _prefs.getInt(key);
  }

  Future<void> setInt(String key, int value) async {
    if (!_initialized) await init();
    await _prefs.setInt(key, value);
  }

  Future<void> deleteData({required String key}) async {
    if (!_initialized) await init();
    await _prefs.remove(key);
  }
} 