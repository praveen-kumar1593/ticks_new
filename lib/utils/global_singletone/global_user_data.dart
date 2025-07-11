import 'dart:convert';

import '../local_storage/share_pref_cache.dart';
import '../local_storage/share_pref_constant_pkg.dart';



class GlobalUserData {
  static final GlobalUserData _instance = GlobalUserData._internal();

  factory GlobalUserData() {
    return _instance;
  }

  GlobalUserData._internal();

  late String sharePrefKey;
  Map<String, dynamic>? userData;

  /// Initialize the service with a shared preferences key
  Future<void> initialize({
    String sharePrefKey = ShareprefConstantPkg.loginUserDetailsData,
  }) async {
    this.sharePrefKey = sharePrefKey;
    await _loadTenantData();
  }

  /// Load Tenant Data from SharedPreferences
  Future<void> _loadTenantData() async {
    final cache = SharePrefCache();

    final jsonString = cache.getString(sharePrefKey);

    if (jsonString != null) {
      userData = Map<String, dynamic>.from(jsonDecode(jsonString));
    }
  }

  Map<String, dynamic>? getUsertData() {
    return userData;
  }
}
