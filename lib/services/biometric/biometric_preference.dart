import 'package:shared_preferences/shared_preferences.dart';

class BiometricPreference {
  static const String biometricKey = "biometric";
  static const String biometricSkipKey = "biometricSkip";

  static Future<void> setBiometricEnabled(bool enabled) async {
    print('[BiometricPreference] Setting biometric enabled: $enabled');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(biometricKey, enabled);
    print('[BiometricPreference] Biometric enabled saved successfully');
  }

  static Future<void> setBiometricSkip(bool skip) async {
    print('[BiometricPreference] Setting biometric skip: $skip');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(biometricSkipKey, skip);
    print('[BiometricPreference] Biometric skip saved successfully');
  }

  static Future<bool?> getBiometricEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getBool(biometricKey);
    print('[BiometricPreference] Getting biometric enabled: $value');
    return value;
  }

  static Future<bool?> getBiometricSkip() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getBool(biometricSkipKey);
    print('[BiometricPreference] Getting biometric skip: $value');
    return value;
  }
}