import 'dart:convert';
import 'package:ticks_new/models/login_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../models/user_data_singleton.dart';

class StorageService extends GetxService {
  late SharedPreferences _prefs;

  @override
  Future<void> onInit() async {
    super.onInit();
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> setString(String key, String value) async {
    print('[StorageService] setString: key=$key, value=$value');
    await _prefs.setString(key, value);
  }

  String? getString(String key) {
    final value = _prefs.getString(key);
    print('[StorageService] getString: key=$key, value=$value');
    return value;
  }

  Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  Future<void> setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  Future<void> setDouble(String key, double value) async {
    await _prefs.setDouble(key, value);
  }

  double? getDouble(String key) {
    return _prefs.getDouble(key);
  }

  Future<void> setStringList(String key, List<String> value) async {
    await _prefs.setStringList(key, value);
  }

  List<String>? getStringList(String key) {
    return _prefs.getStringList(key);
  }

  bool containsKey(String key) {
    return _prefs.containsKey(key);
  }

  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  Future<void> clear() async {
    await _prefs.clear();
  }

  static const _accessTokenKey = 'accessToken';
  static const _refreshTokenKey = 'refreshToken';
  static const _expireInKey = 'expireIn';
  static const _lastTokenTimeKey = 'lastTokenTime';
  static const _userKey = 'user';

  Future<void> saveTokens({
    required String authToken,
    required String refreshToken,
    String expireIn = '3600',
  }) async {
    await _prefs.setString(_accessTokenKey, authToken);
    await _prefs.setString(_refreshTokenKey, refreshToken);
    await _prefs.setString(_expireInKey, expireIn);
    await _prefs.setString(_lastTokenTimeKey, DateTime.now().toString());
  }

  Future<String?> getAuthToken() async {
    final value = _prefs.getString(_accessTokenKey);
    print('[StorageService] getAuthToken: key=$_accessTokenKey, value=$value');
    return value;
  }

  Future<String?> getRefreshToken() async {
    return _prefs.getString(_refreshTokenKey);
  }

  Future<String?> getExpireIn() async {
    return _prefs.getString(_expireInKey);
  }

  Future<String?> getLastTokenTime() async {
    return _prefs.getString(_lastTokenTimeKey);
  }

  Future<void> deleteAllTokens() async {
    print('[StorageService] Deleting all tokens and user data');
    await _prefs.remove(_accessTokenKey);
    await _prefs.remove(_refreshTokenKey);
    await _prefs.remove(_expireInKey);
    await _prefs.remove(_lastTokenTimeKey);
    await _prefs.remove(_userKey);
  }

  Future<void> saveUser(User user) async {
    final userJson = jsonEncode(user.toJson());
    await _prefs.setString(_userKey, userJson);
  }

  Future<User?> getUser() async {
    final userJson = _prefs.getString(_userKey);
    if (userJson != null) {
      return User.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  Future<void> writeUserData(Map<String, dynamic> userData) async {
    await _prefs.setString(_userKey, jsonEncode(userData));
    UserDataSingleton().initializeWithLoginData(userData);
  }

  void storeMangedById(String value) {
    _prefs.setString('managedById', value);
  }

  void storeUserId(String value) {
    _prefs.setString('userId', value);
  }

  Future<String?> getUserId() async {
    try {
      var data = _prefs.getString('userId');
      return data;
    } catch (_) {
      return null;
    }
  }

  Future<void> readUserDataAndSetToSingleTon() async {
    try {
      UserDataSingleton userDataSingleton = UserDataSingleton();

      String? value = _prefs.getString(_userKey);
      String? managedById = _prefs.getString('managedById');
      String? userId = await getUserId();
      if (userId != null && int.tryParse(userId) != null) {
        userDataSingleton.setUserId = userId;
      }

      if (value != null) {
        Map<String, dynamic> data = jsonDecode(value);

        userDataSingleton.initializeWithLoginData(data);
      }

      if (managedById != null) {
        userDataSingleton.setManagedId = managedById;
      }

      if (userId != null) {
        userDataSingleton.setUserId = userId;
      }
    } catch (e) {
      // if (kDebugMode) {
      //   // Handle exception
      // }
    }
  }
} 