import 'dart:convert';

import '../local_storage/share_pref_cache.dart';
import '../local_storage/share_pref_constant_pkg.dart';



class GlobalTenantData {
  static final GlobalTenantData _instance = GlobalTenantData._internal();

  factory GlobalTenantData() {
    return _instance;
  }

  GlobalTenantData._internal();

  late String sharePrefKey;
  Map<String, dynamic>? tenantData;

  /// Initialize the service with a shared preferences key
  Future<void> initialize({
    String sharePrefKey = ShareprefConstantPkg.loginUserTenantData,
  }) async {
    this.sharePrefKey = sharePrefKey;
    await _loadTenantData();
  }

  /// Load Tenant Data from SharedPreferences
  Future<void> _loadTenantData() async {
    final cache = SharePrefCache();

    final jsonString = cache.getString(sharePrefKey);

    if (jsonString != null) {
      tenantData = Map<String, dynamic>.from(jsonDecode(jsonString));
    }
  }

  Map<String, dynamic>? getTenantData() {
    return tenantData;
  }
}
