import 'package:get/get.dart';
import 'package:ticks_new/services/user_auth_services.dart';
import 'package:ticks_new/services/storage_services.dart';
import 'package:ticks_new/models/login_response_model.dart';
import 'package:ticks_new/utils/unique_id_finder.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ticks_new/models/user_data_singleton.dart';
import 'package:ticks_new/services/api_services.dart';
import 'package:ticks_new/models/nectar_app_theme.dart';
import 'package:ticks_new/services/graphql_client_services.dart';
import 'package:ticks_new/utils/helpers/common_snackbar.dart';
import '../modules/geofence/geofence_new_service.dart';
import '../modules/shift_details/controllers/shift_details_controller.dart';
import 'attendance_controller.dart';

import '../constants/custom_snackbar.dart';
import '../graphql/__generated__/get_form_template.ast.gql.dart' as appThemeData;
import '../graphql/__generated__/get_form_template.data.gql.dart';

class AuthController extends GetxController {
  final UserAuthServices _authService = Get.find<UserAuthServices>();
  final StorageService _storageService = Get.find<StorageService>();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final UserDataSingleton _userDataSingleton = Get.find<UserDataSingleton>();
  final ApiServices _apiServices = Get.find<ApiServices>();
  final GraphQLClientService _graphQLService = Get.find<GraphQLClientService>();

  final RxBool isAuthenticated = false.obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final Rx<User?> _user = Rx<User?>(null);
  UserDataSingleton? userData;

  User? get user => _user.value;

  @override
  void onInit() {
    super.onInit();
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    print('🔵 AuthController: Checking auth status...');
    final token = await _storageService.getAuthToken();
    if (token != null) {
      final user = await _storageService.getUser();
      if (user != null) {
        _user.value = user;
        _userDataSingleton.initializeWithLoginData(user.toJson());
        isAuthenticated.value = true;
        // Rebuild the client now that we have a confirmed session token

        print('✅ AuthController: User restored from storage.');
      } else {
        // Token exists but user data is missing. Treat as not logged in.
        await logout();
        print('❌ AuthController: Token found, but no user data. Forcing logout.');
      }
    } else {
      isAuthenticated.value = false;
      _user.value = null;
      _userDataSingleton.clearUserData();
    }
  }

  // Check if onboarding is completed
  Future<bool> isOnboardingCompleted() async {
    try {
      final onboardingCompleted = await _secureStorage.read(key: 'onboarding_completed');
      return onboardingCompleted == 'true';
    } catch (e) {
      print('Error checking onboarding status: $e');
      return false;
    }
  }

  // Mark onboarding as completed
  Future<void> markOnboardingCompleted() async {
    try {
      await _secureStorage.write(key: 'onboarding_completed', value: 'true');
      print('Onboarding marked as completed');
    } catch (e) {
      print('Error marking onboarding as completed: $e');
    }
  }

  // Clear onboarding status (for testing or reset)
  Future<void> clearOnboardingStatus() async {
    try {
      await _secureStorage.delete(key: 'onboarding_completed');
      print('Onboarding status cleared');
    } catch (e) {
      print('Error clearing onboarding status: $e');
    }
  }

  // Save credentials securely for remember me functionality
  Future<void> saveCredentials(String username, String password) async {
    try {
      await _secureStorage.write(key: 'remembered_username', value: username);
      await _secureStorage.write(key: 'remembered_password', value: password);
      await _secureStorage.write(key: 'remember_me_enabled', value: 'true');
      print('Credentials saved securely');
    } catch (e) {
      print('Error saving credentials: $e');
    }
  }

  // Retrieve saved credentials
  Future<Map<String, String?>> getSavedCredentials() async {
    try {
      final username = await _secureStorage.read(key: 'remembered_username');
      final password = await _secureStorage.read(key: 'remembered_password');
      final rememberMeEnabled = await _secureStorage.read(key: 'remember_me_enabled');
      
      if (rememberMeEnabled == 'true' && username != null && password != null) {
        return {'username': username, 'password': password};
      }
      return {'username': null, 'password': null};
    } catch (e) {
      print('Error retrieving credentials: $e');
      return {'username': null, 'password': null};
    }
  }

  // Clear saved credentials
  Future<void> clearSavedCredentials() async {
    try {
      await _secureStorage.delete(key: 'remembered_username');
      await _secureStorage.delete(key: 'remembered_password');
      await _secureStorage.delete(key: 'remember_me_enabled');
      print('Saved credentials cleared');
    } catch (e) {
      print('Error clearing credentials: $e');
    }
  }

  // Auto-login with saved credentials
  Future<bool> autoLogin() async {
    try {
      final credentials = await getSavedCredentials();
      if (credentials['username'] != null && credentials['password'] != null) {
        print('Attempting auto-login with saved credentials');
        final result = await _authService.login(credentials['username']!, credentials['password']!);
        if (result['success']) {
          await checkAuthStatus();
          return true;
        }
      }
      return false;
    } catch (e) {
      print('Auto-login failed: $e');
      return false;
    }
  }

  Future<void> login(String userName, String password, {bool rememberMe = false}) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      // This now waits for the entire login process, including token saving and client rebuild, to complete.
      final result = await _authService.login(userName, password);
      
      if (result['success']) {
        // The user data is returned by the auth service, so we can use it directly.
        final userMap = result['data'] as Map<String, dynamic>?;
        if (userMap == null) {
          throw Exception('Login successful, but no user data was returned.');
        }

        final userObj = User.fromJson(userMap);

        // 1. Save user data to persistent storage FIRST
        await _storageService.saveUser(userObj);

        // 2. Update in-memory state
        _user.value = userObj;
        // The singleton is already initialized within UserAuthServices, but we ensure it's consistent here.
        _userDataSingleton.initializeWithLoginData(userObj.toJson());
        
        // 3. Handle "Remember Me"
        if (rememberMe) {
          await saveCredentials(userName, password);
        } else {
          await clearSavedCredentials();
        }
        
        print('✅ AuthController: Login process complete. Notifying app state.');
        // Wait for token and rebuild client
        final graphQLService = Get.find<GraphQLClientService>();
        int retries = 0;
        String token = await graphQLService.getToken();
        while (token.isEmpty && retries < 50) {
          await Future.delayed(const Duration(milliseconds: 100));
          token = await graphQLService.getToken();
          retries++;
        }

        if (token.isNotEmpty) {
          // Await the client rebuild to ensure the token is attached before any requests
          await Future.sync(() => _graphQLService.rebuildAuthenticatedClient());
          // Now it's safe to make authenticated requests
          await Get.find<ShiftDetailsController>().fetchShiftDetails();
          isAuthenticated.value = true;
          rShowCustomSnackbar(message: "Login Successfully", snackbarType: SnackbarType.success);
          await Get.find<GeofenceNewService>().fetchGeofencesDirectHttp(domain: "buildingdemo");
          Get.offAllNamed('/main');
        } else {
          errorMessage.value = "Login failed: Could not retrieve authentication token. Please try again.";
          isAuthenticated.value = false;
          rShowCustomSnackbar(message: errorMessage.value, snackbarType: SnackbarType.error);
        }

        // 4. Rebuild the authenticated client with the new token before proceeding
        //  _graphQLService.rebuildAuthenticatedClient();
        // int retries = 0;
        // while ((_userDataSingleton.userId.isEmpty || int.tryParse(_userDataSingleton.userId) == null) && retries < 50) {
        //   await Future.delayed(const Duration(milliseconds: 100));
        //   retries++;
        // }
        //
        // // 5. NOW it's safe to update the authentication state.
        // isAuthenticated.value = true;
        //
        // rShowCustomSnackbar(message: "Login Successfully", snackbarType: SnackbarType.success);
        // await Get.find<GeofenceNewService>().fetchGeofencesDirectHttp(domain: "buildingdemo");
        // Get.offAllNamed('/main');
        
      } else {
        errorMessage.value = result['message'] ?? 'An unknown login error occurred.';
        isAuthenticated.value = false;
      }
    } catch (e, stack) {
      print('AuthController: Login failed with error: $e');
      print('Stack trace: $stack');
      errorMessage.value = e.toString().replaceFirst("Exception: ", "");
      isAuthenticated.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchAndApplyTheme() async {
    try {
      final domain = _userDataSingleton.domain;
      if (domain == null || domain.isEmpty) {
        print('⚠️ AuthController: Cannot fetch theme, domain is null or empty.');
        return;
      }

      final response = await _apiServices.getFormTemplate(
        domain: "buildingdemo",
       // domain: userData!.domain,
        name: 'APP_THEME',
      );

      if (response.success && response.data != null) {
        final GgetFormTemplateData? templateResponse = response.data;
        final templateData = templateResponse?.getFormTemplate;
        
        if (templateData != null) {
          try {
            // Convert the JsonObject to a string before parsing
            final NectarAppTheme appTheme = nectarAppThemeFromJson(templateData.toString());
            
            // Save theme to SharedPreferences
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('app_theme', jsonEncode(appTheme.toJson()));
            
            if (appTheme.asMap != null) {
              final data = appTheme.asMap!;
              // Update singleton with theme color if available
              if (data['themeColor'] != null) {
               // _userDataSingleton.setThemeColor(data['themeColor'] as String);
              }
            }
            
            print('✅ AuthController: Theme data saved and applied successfully.');
            print('Theme color: ${appTheme.themeColor}');
            print('Primary color: ${appTheme.primaryColor}');
          } catch (e) {
            print('❌ AuthController: Error parsing app theme: $e');
          }
        } else {
          print('⚠️ AuthController: Template data is null');
        }
      } else {
        print('❌ AuthController: Failed to fetch theme data. Error: ${response.error}');
      }
    } catch (e) {
      print('❌ AuthController: Exception while fetching theme: $e');
    }
  }

  // Direct HTTP GraphQL login
  Future<Map<String, dynamic>> directLoginHttp({
    required String username,
    required String password,
    required String endpoint,
  }) async {
    final query = '''
      query login(
        \$credentials: JSON, \$isDevMode: Boolean, \$origin: String
      ) {
        login(credentials: \$credentials, isDevMode: \$isDevMode, origin: \$origin)
      }
    ''';
    final variables = {
      "credentials": {
        "userName": username,
        "password": password,
      },
      "isDevMode": true,
      "origin": "mobile"
    };
    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'query': query,
        'variables': variables,
      }),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      if (body['errors'] != null) {
        print('GraphQL errors: \\${body['errors']}');
        return {'success': false, 'message': body['errors'].toString()};
      }
      final loginResult = body['data']?['login'];
      if (loginResult == null) {
        return {'success': false, 'message': 'No login data returned'};
      }
      return {'success': true, 'login': loginResult};
    } else {
      print('HTTP error: \\${response.statusCode}');
      return {'success': false, 'message': 'HTTP error: \\${response.statusCode}'};
    }
  }

  Future<void> logout() async {
    try {
      await _storageService.deleteAllTokens(); // This also removes the user from storage
      _user.value = null;
      _userDataSingleton.clearUserData();
      isAuthenticated.value = false;
      await clearSavedCredentials();
      print('🔵 AuthController: User logged out successfully.');
      // The UI will react to isAuthenticated.value = false and navigate to the login screen.
    } catch (e, stack) {
      print('Logout error: $e');
      print(stack);
    }
  }
}