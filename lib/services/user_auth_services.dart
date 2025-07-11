import 'dart:io';
import 'dart:convert';

import 'package:ticks_new/graphql/__generated__/login.req.gql.dart';
import 'package:ticks_new/graphql/__generated__/findAssignee.req.gql.dart';

import 'package:ticks_new/services/graphql_client_services.dart';
import 'package:ticks_new/services/shared_preferences_services.dart';
import 'package:ticks_new/services/storage_services.dart';
import 'package:ticks_new/services/tenant_services.dart';
import 'package:built_value/json_object.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:gql/language.dart' as lang;

import '../graphql/__generated__/schema.schema.gql.dart';
import '../graphql/schemas/user_auth_schemas.dart';
import '../models/user_data_singleton.dart';
import '../utils/global_singletone/global_permission.dart';
import '../utils/local_storage/share_pref_cache.dart';
import '../utils/local_storage/share_pref_constant_pkg.dart';

class UserAuthServices extends GetxService {
  final GraphQLClientService _graphQLClientService = Get.find<GraphQLClientService>();
  final StorageService _storageService = Get.find<StorageService>();
  final _connectivity = Connectivity();
  late final SharedPrefrencesServices sharedPrefrencesServices;
  late final UserDataSingleton userDataSingleton;
  late final StorageService storage;
  late final TenantServices tenantServices;

  @override
  void onInit() async {
    super.onInit();
    sharedPrefrencesServices = Get.find<SharedPrefrencesServices>();
    userDataSingleton = Get.find<UserDataSingleton>();
    storage = Get.find<StorageService>();
    tenantServices = Get.find<TenantServices>();
  }

  Future<bool> checkConnectivity() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    print('UserAuthServices: login called with username: $username');
    try {
      if (!await checkConnectivity()) {
        print('UserAuthServices: No internet connection');
        return {
          'success': false,
          'message': 'No internet connection',
        };
      }

      print('UserAuthServices: Building login request');
      final loginRequest = GloginReq((b) => b
        ..vars.credentials = JsonObject({'userName': username, 'password': password})
        ..vars.isDevMode = true
        ..vars.origin = 'mobile'
      );
      print('UserAuthServices: Sending login request: $loginRequest');
      final response = await _graphQLClientService.noTokenClient.request(loginRequest).first;
      print('UserAuthServices: Received response: $response');
      print('UserAuthServices: Response data: ${response.data}');

      if (response.hasErrors) {
        print('UserAuthServices: Full GraphQL errors: ${response.graphqlErrors}');
        print('UserAuthServices: Link Exception: ${response.linkException}');

        String errorMessage = 'An unknown error occurred.';
        if (response.graphqlErrors != null && response.graphqlErrors!.isNotEmpty) {
          errorMessage = response.graphqlErrors!.map((e) => e.message).join(', ');
        } else if (response.linkException != null) {
          errorMessage = 'Network error: ${response.linkException.toString()}';
        }

        print('UserAuthServices: GraphQL error messages: $errorMessage');
        return {
          'success': false,
          'message': errorMessage,
        };
      }

      final loginData = response.data?.login;
      if (loginData == null || loginData.value == null) {
        print('UserAuthServices: Login failed (no accessToken returned)');
        return {
          'success': false,
          'message': 'Login failed (no accessToken returned)',
        };
      }

      final loginDataMap = jsonDecode(jsonEncode(loginData.value)) as Map<String, dynamic>;
      print('[UserAuthServices] loginDataMap: ' + loginDataMap.toString());
      final userObject = loginDataMap['user'] as Map<String, dynamic>?;

      if (userObject == null) {
        return {'success': false, 'message': 'Login successful, but no user data returned.'};
      }
      
      final accessToken = loginDataMap['accessToken'] as String?;
      final refreshToken = loginDataMap['refreshToken'] as String?;
      final expireIn = loginDataMap['expireIn']?.toString();

      if (accessToken == null || accessToken.isEmpty) {
        print('UserAuthServices: Login failed (no accessToken returned)');
        return {
          'success': false,
          'message': 'Login failed (no accessToken returned)',
        };
      }
      print('[UserAuthServices] About to save accessToken: $accessToken');
      try {
        await _storageService.setString('accessToken', accessToken);
        print('[UserAuthServices] accessToken saved successfully');
      } catch (e) {
        print('[UserAuthServices] Error saving accessToken: $e');
      }
      if (refreshToken != null) {
        await _storageService.setString('refreshToken', refreshToken);
      }
      if (expireIn != null) {
        await _storageService.setString('expireIn', expireIn);
      }
      await _storageService.setString('lastTokenTime', DateTime.now().toString());
      final permissions = loginDataMap['permissions'];
      if (permissions != null) {
        final cache = SharePrefCache();
        await cache.saveMap(
          ShareprefConstantPkg.loginUserPermissionList,
          permissions is Map<String, dynamic> ? permissions : Map<String, dynamic>.from(permissions),
        );
        GlobalPermissions().initialize();
      }

      // Rebuild the main client with the new token. This is now the single source of truth.
      _graphQLClientService.rebuildAuthenticatedClient(token: accessToken);

      userDataSingleton.initializeWithLoginData(userObject);
      print('UserAuthServices: Login successful, accessToken: $accessToken');

      if (userDataSingleton.userType == "Manager") {
        final findAssigneeReq = GfindAssigneeReq(
          (b) => b..vars.id = "${userDataSingleton.userName}@${userDataSingleton.domain}",
        );

        final response = await _graphQLClientService.client.request(findAssigneeReq).first;
        var assigneeJson = response.data?.findAssignee;

        if (assigneeJson != null && assigneeJson.value != null) {
          final assigneeMap = jsonDecode(jsonEncode(assigneeJson.value)) as Map<String, dynamic>;
          await sharedPrefrencesServices.setData(
            "findAssignee",
            jsonEncode(assigneeMap),
          );
          String? value = assigneeMap['id']?.toString();
          if (value != null) {
            storage.storeMangedById(value);
            userDataSingleton.setManagedId = value;
          }
        }
      } else if (userDataSingleton.userType == "Tenant") {
        tenantServices.callbillingTenantApi(
            identifier: "${userDataSingleton.userName}@${userDataSingleton.domain}");
      } else if (userDataSingleton.userType == "Mechanic" || userDataSingleton.userType == "Operator") {
        try {
          final findAssigneeReq = GfindAssigneeReq(
            (b) => b..vars.id = "${userDataSingleton.userName}@${userDataSingleton.domain}",
          );
          debugPrint("✅ [AuthService] Making findAssignee request for user: ${userDataSingleton.userName}@${userDataSingleton.domain}");
          final response = await _graphQLClientService.client.request(findAssigneeReq).first;
          
          debugPrint("✅ [AuthService] findAssignee raw response: ${response.data?.toJson()}");
          var assigneeJson = response.data?.findAssignee;

          if (assigneeJson != null && assigneeJson.value != null) {
            debugPrint("✅ [AuthService] findAssignee data found. Saving to storage...");

            final assigneeMap = jsonDecode(jsonEncode(assigneeJson.value)) as Map<String, dynamic>;

            await sharedPrefrencesServices.setData(
              "findAssignee",
              jsonEncode(assigneeMap),
            );

            String? userId = assigneeMap['id']?.toString();
            if (userId != null) {
              storage.storeUserId(userId);
              userDataSingleton.setUserId = userId;
              debugPrint('[AuthService] Set userId in singleton: $userId');
            }
            debugPrint("✅ [AuthService] findAssignee data saved successfully");

          } else {
            debugPrint("⚠️ [AuthService] findAssignee data is NULL, but continuing with basic login data");

            // Don't fail the login, just log a warning
          }
        } catch (e) {
          debugPrint("⚠️ [AuthService] findAssignee request failed: $e, but continuing with basic login data");
          // Don't fail the login, just log the error
        }
      }

      return {
        'success': true,
        'data': userObject,
        'accessToken': accessToken,
      };
    } catch (e, stack) {
      print('UserAuthServices: Login error: $e');
      print('Stack trace: $stack');
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }

  // Future<bool> logout() async {
  //   try {
  //     if (!await checkConnectivity()) {
  //       return false;
  //     }
  //
  //     final logoutRequest = GLogoutReq();
  //     final response = await _graphQLClientService.request(logoutRequest);
  //
  //     if (response.hasErrors) {
  //       debugPrint('Logout errors: ${response.graphqlErrors}');
  //     }
  //
  //     await _storageService.clear();
  //     return true;
  //   } catch (e) {
  //     debugPrint('Logout error: $e');
  //     await _storageService.clear();
  //     return false;
  //   }
  // }

  Future<Map<String, dynamic>> _getDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();
    String deviceId = '';
    String deviceName = '';

    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.id;
        deviceName = androidInfo.model;
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor ?? '';
        deviceName = iosInfo.name;
      }
    } catch (e) {
      debugPrint('Error getting device info: $e');
    }

    return {
      'deviceId': deviceId,
      'deviceName': deviceName,
    };
  }

  Future<bool> isLoggedIn() async {
    final token = _storageService.getString('accessToken');
    return token != null && token.isNotEmpty;
  }

  Future<Map<String, dynamic>> getUserData() async {
    return {
      'userId': _storageService.getString('userId') ?? '',
      'userName': _storageService.getString('userName') ?? '',
      'displayName': _storageService.getString('displayName') ?? '',
      'emailId': _storageService.getString('emailId') ?? '',
      'contactNumber': _storageService.getString('contactNumber') ?? '',
      'domain': _storageService.getString('domain') ?? '',
      'userType': _storageService.getString('userType') ?? '',
    };
  }
}