import 'package:get/get.dart';

import '../../../models/login_response_model.dart';
import '../../../utils/global_singletone/global_user_data.dart';
import '../../../utils/local_storage/share_pref_cache.dart';
import '../../../utils/local_storage/share_pref_constant_pkg.dart';


class RLogout {
  static Future<void> loggedOut({bool skipUnsubscribe = false}) async {
    final cache = SharePrefCache();

    // Always preserve the rememberMe flag
    final rememberMe = cache.getBool(ShareprefConstantPkg.rememberMe) ?? false;
    final savedUsername = cache.getString(ShareprefConstantPkg.loginUserName);
    final savedPassword = cache.getString(ShareprefConstantPkg.loginUserPassword);

    // Define keys to exclude from clearing
    List<String> excludedKeys = [
      ShareprefConstantPkg.biometricEnabled,
      ShareprefConstantPkg.skipOnBoarding,
      ShareprefConstantPkg.rememberMe,
    ];

    if (rememberMe) {
      // Preserve credentials too
      if (savedUsername != null) excludedKeys.add(ShareprefConstantPkg.loginUserName);
      if (savedPassword != null) excludedKeys.add(ShareprefConstantPkg.loginUserPassword);
    }

    // Clear everything except the excluded keys
    await cache.clearAll(excludedKeys: excludedKeys);

    // Unsubscribe from Firebase topics
    if (!skipUnsubscribe) {
      final userJson = GlobalUserData().getUsertData();
      if (userJson != null) {
        User userData = User.fromJson(userJson);
       // FirebaseMessageSetup().unsubscribeFromAlarmTopic(domain: userData.domain);
      }
    }

    // Navigate to login
    Get.offAllNamed('/login');
  }
}

