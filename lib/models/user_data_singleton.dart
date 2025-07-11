import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class UserDataSingleton {
  static final UserDataSingleton _instance = UserDataSingleton._internal();

  factory UserDataSingleton() {
    return _instance;
  }

  UserDataSingleton._internal() {
    print('UserDataSingleton instance created: [32m[1m$hashCode[0m');
  }

  String _userId = '';
  RxString userName = ''.obs;
  String _displayName = '';
  String _emailId = '';
  String _contactNumber = '';
  String _domain = '';
  String _userType = '';
  String _managedBy = '';
  Map<String, dynamic> _tenant = {};
  bool _isVendor = false;
  String? _role;
  List<String>? _permissions;

  // Getters
  String get userId => _userId;
  String get userNameString => userName.value;
  String get displayName => _displayName;
  String get emailId => _emailId;
  String get contactNumber => _contactNumber;
  String get domain => _domain;
  String get userType => _userType;
  String get manageBy => _managedBy;
  Map<String, dynamic> get tenant => _tenant;
  bool get isVendor => _isVendor;
  String? get role => _role;
  List<String>? get permissions => _permissions;

  // Setters
  set userId(String value) => _userId = value;
  set displayName(String value) => _displayName = value;
  set emailId(String value) => _emailId = value;
  set contactNumber(String value) => _contactNumber = value;
  set domain(String value) => _domain = value;
  set userType(String value) => _userType = value;
  set setManagedId(String value) => _managedBy = value;
  set setUserId(String value) => _userId = value;
  set role(String? value) => _role = value;
  set permissions(List<String>? value) => _permissions = value;

  // Initialize user data
  void initializeUserData({
    required String userId,
    required String userName,
    required String displayName,
    required String emailId,
    required String contactNumber,
    required String domain,
    required String userType,
    String? role,
    List<String>? permissions,
  }) {
    _userId = userId;
    this.userName.value = userName;
    _displayName = displayName;
    _emailId = emailId;
    _contactNumber = contactNumber;
    _domain = domain;
    _userType = userType;
    _role = role;
    _permissions = permissions;
  }

  void initializeWithLoginData(dynamic user) {
    if (user == null) return;

    try {
      print('🔵 UserDataSingleton: Initializing with login data');
      print('🔵 Raw user data: $user');
      
      _userType = user['type'] ?? '';

      final userData = user['data'];
      print('🔵 userData: $userData');
      
      if (userData != null) {
        userName.value = userData['userName'] ?? '';
        print('Set userName to: [36m${userName.value}[0m in instance $hashCode');
        
        _domain = userData['domain'] ?? '';
        print('🔵 Domain extracted: "$_domain"');
        
        // If domain is empty, try to extract from username (if it's an email)
        if (_domain.isEmpty && userName.value.isNotEmpty && userName.value.contains('@')) {
          _domain = userName.value.split('@').last;
          print('🔵 Domain extracted from username: "$_domain"');
        }
        
        // If still empty, use a default domain (you can change this to your actual domain)
        if (_domain.isEmpty) {
          _domain = 'nectarit.com'; // Change this to your actual default domain
          print('🔵 Using default domain: "$_domain"');
        }
        
        _displayName = userData['firstName'] ?? '';
        _emailId = userData['emailId'] ?? '';
        _contactNumber = userData['contactNumber'] ?? '';
        
        // Extract role and permissions from user data
        _role = userData['role'] ?? userData['userRole'] ?? userData['type'];
        
        // Parse permissions - could be string, list, or null
        final permissionsData = userData['permissions'] ?? userData['userPermissions'];
        if (permissionsData != null) {
          if (permissionsData is List) {
            _permissions = permissionsData.cast<String>();
          } else if (permissionsData is String) {
            _permissions = permissionsData.split(',').map((e) => e.trim()).toList();
          }
        }
      }

      // Set userId from login data - this should be available immediately
      // _userId = user['identifier'] ?? user['id'] ?? '';
      //
      // // If userId is still empty, try to construct it from username and domain
      // if (_userId.isEmpty && userName.value.isNotEmpty && _domain.isNotEmpty) {
      //   _userId = "${userName.value}@${_domain}";
      //   print('🔵 Constructed userId from username and domain: "$_userId"');
      // }
      //
      // print('🔵 Final user data - ID: "$_userId", Domain: "$_domain", Name: "$_displayName"');
      if (_userId.isEmpty && user['id'] != null && int.tryParse(user['id'].toString()) != null) {
        _userId = user['id'].toString();
      }

    } catch (e) {
      debugPrint("❌ Error parsing user data in singleton: $e");
      clearUserData();
    }
  }

  // Clear user data (for logout)
  void clearUserData() {
    _userId = '';
    userName.value = '';
    _displayName = '';
    _emailId = '';
    _contactNumber = '';
    _domain = '';
    _userType = '';
    _managedBy = '';
    _tenant = {};
    _isVendor = false;
    _role = null;
    _permissions = null;
  }

  // Check if user is logged in
  bool get isLoggedIn => _userId.isNotEmpty;
  
  // Debug method to get user data as JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': _userId,
      'userName': userName.value,
      'displayName': _displayName,
      'emailId': _emailId,
      'contactNumber': _contactNumber,
      'domain': _domain,
      'userType': _userType,
      'managedBy': _managedBy,
      'role': _role,
      'permissions': _permissions,
      'isVendor': _isVendor,
      'isLoggedIn': isLoggedIn,
    };
  }
} 